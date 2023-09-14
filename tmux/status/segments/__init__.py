class Segment:
    RTL_FULL = ""
    RTL_SOFT = ""

    LTR_FULL = ""
    LTR_SOFT = ""

    def __init__(
        self, content="", bgcolor="default", fgcolor="default", full=True, visible=True
    ):
        self.content = content
        self._bgcolor = bgcolor
        self._fgcolor = fgcolor
        self.full = full
        self.visible = visible

    @property
    def bgcolor(self):
        return self._bgcolor

    @property
    def fgcolor(self):
        return self._fgcolor

    @property
    def left_separator(self):
        return Segment.LTR_FULL if self.full else Segment.LTR_SOFT

    @property
    def right_separator(self):
        return Segment.RTL_FULL if self.full else Segment.RTL_SOFT

    def build(self):
        return f"#[fg={self.fgcolor},bg={self.bgcolor}]{self.content}"


class SegmentGroup:
    def __init__(self, segments, side="left", visible=True):
        self.segments = segments
        self.side = side
        self.visible = visible

    @property
    def bgcolor(self):
        if len(self.segments) == 0:
            return "default"
        return self.segments[0].bgcolor

    @property
    def fgcolor(self):
        if len(self.segments) == 0:
            return "default"
        return self.segments[0].fgcolor

    def separator(self, side):
        if len(self.segments) == 0:
            return ""
        return self.segments[0].separator(side)

    def build(self):
        if len(self.segments) == 0:
            return ""

        result = ""
        for i, segment in enumerate(self.segments):
            if not segment.visible:
                continue

            is_group = isinstance(segment, SegmentGroup)
            next_bg = "default"

            for j in range(1, len(self.segments)):
                if self.side == "left":
                    if i + j < len(self.segments) and self.segments[i + j].visible:
                        next_bg = self.segments[i + j].bgcolor
                        if segment.bgcolor != next_bg:
                            segment.full = True
                        break
                else:
                    if i - j >= 0 and self.segments[i - j].visible:
                        next_bg = self.segments[i - j].bgcolor
                        if segment.bgcolor != next_bg:
                            segment.full = True
                        break

            if is_group:
                segment.side = self.side
            else:
                if self.side == "right":
                    next_fg = segment.bgcolor if segment.full else segment.fgcolor
                    result += f"#[fg={next_fg},bg={next_bg}]{segment.right_separator}"
                result += f"#[bg={segment.bgcolor},fg={segment.fgcolor}] "

            result += segment.build()

            if not is_group:
                result += " "
                next_fg = segment.bgcolor if segment.full else segment.fgcolor
                if self.side == "left":
                    result += f"#[fg={next_fg},bg={next_bg}]{segment.left_separator}"
        return result
