import datetime
import colorama

class Logger:
    def __init__(self):
        colorama.init()

    def time_now(self) -> str:
        now = datetime.datetime.now()
        return "[{}:{}:{}]".format(now.hour, 
                                   "0" + str(now.minute) if len(str(now.minute)) == 1 else now.minute, 
                                   "0" + str(now.second) if len(str(now.second)) == 1 else now.second)

    def error(self, message: str):
        print(colorama.Fore.RED + ("{} [ERROR] ".format(self.time_now()) + message))

    def success(self, message: str):
        print(colorama.Fore.GREEN + ("{} [SUCCESS] ".format(self.time_now()) + message))

    def log(self, message: str):
        print(colorama.Fore.YELLOW + ("{} [LOG] ".format(self.time_now()) + message))
