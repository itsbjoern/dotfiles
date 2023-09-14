from segments import Segment, SegmentGroup
from tmux import Tmux


def if_prefix_active(_if, _else):
    return f"#{{?client_prefix,{_if}, {_else}}}"


class WindowsSegment(SegmentGroup):
    def __init__(
        self,
        default_bg_color="default",
        default_fg_color="default",
        active_bg_color="default",
        active_fg_color="default",
    ):
        self.default_bg_color = default_bg_color
        self.default_fg_color = default_fg_color
        self.active_bg_color = active_bg_color
        self.active_fg_color = active_fg_color

        windows = Tmux.get_windows()

        segments = []
        for i, window in enumerate(windows):
            buffer = " " * len(window.window_name)
            content = if_prefix_active(buffer + window.window_id, window.window_name)
            segments.append(
                Segment(
                    content=content,
                    bgcolor=self.active_bg_color
                    if window.is_active
                    else self.default_bg_color,
                    fgcolor=self.active_fg_color
                    if window.is_active
                    else self.default_fg_color,
                    full=True if i + 1 == len(windows) or window.is_active else False,
                )
            )

        super().__init__(segments)
