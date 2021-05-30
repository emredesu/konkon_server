class FatalException(Exception):
    def __init__(self):
        print("\nAn irrecoverable error has occured and the server had to stop.")