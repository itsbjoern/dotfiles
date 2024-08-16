import os

from util import shell
import const


class Window:
    attrs = ["*", "-", "#", "!", "~", "M", "Z"]

    def __init__(self, window_id, window_name, pane_count, attrs):
        self.window_id = window_id
        self.window_name = window_name
        self.pane_count = pane_count
        self.attrs = attrs

    @property
    def is_active(self):
        return "*" in self.attrs

    @property
    def was_last_active(self):
        return "-" in self.attrs

    @property
    def has_activity(self):
        return "#" in self.attrs

    @property
    def shows_bell(self):
        return "!" in self.attrs

    @property
    def is_silent(self):
        return "~" in self.attrs

    @property
    def is_marked(self):
        return "M" in self.attrs

    @property
    def is_zoomed(self):
        return "Z" in self.attrs


class Session:
    def __init__(self, session_id, window_count, active):
        self.session_id = session_id
        self.window_count = window_count
        self.active = active


class Tmux:
    @staticmethod
    def exec(cmd):
        val = shell(f"tmux {cmd}")
        return val

    @staticmethod
    def get_var(var):
        return Tmux.exec(f'display -p "{var}"')

    @staticmethod
    def get_env_var(var):
        pane_id = Tmux.get_var(const.pane_id)
        env_path = f"/Users/bjoern/.tmux/.panes/{pane_id}"
        if not os.path.exists(env_path):
            return None
        with open(env_path, "r") as fh:
            env = fh.read().strip().split("\n")
            for line in env:
                [key, val] = line.split("=", 1)
                if key == var:
                    return val

    @staticmethod
    def get_session_id():
        return Tmux.exec("display-message -p '#S'")

    @staticmethod
    def get_sessions():
        sessions_str = Tmux.exec("list-sessions")
        session_strs = sessions_str.split("\n")
        sessions = []
        for session_str in session_strs:
            if session_str == "":
                continue
            session_data = session_str.split(" ")
            id_str = session_data[0][:-1]
            windows_count = int(session_data[1])
            active = "attached" in session_str

            sessions.append(Session(id_str, windows_count, active))

        return sessions

    @staticmethod
    def get_windows():
        window_str = Tmux.exec("list-windows")
        window_strs = window_str.split("\n")
        windows = []
        for window_str in window_strs:
            if window_str == "":
                continue
            window_data = window_str.split(" ")
            id_str = window_data[0][:-1]
            name_str = window_data[1]
            pane_str = window_data[2]
            pane_count = int(pane_str[1:].split(" ")[0])

            attrs = []
            i = 0
            while i < len(Window.attrs):
                if name_str.endswith(Window.attrs[i]):
                    attrs.append(Window.attrs[i])
                    name_str = name_str[:-1]
                    i = 0
                    continue
                i += 1

            windows.append(Window(id_str, name_str, pane_count, attrs))
        return windows
