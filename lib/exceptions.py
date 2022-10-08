class ConfigurationFileNotFound(Exception):
    """
    This exception is raised when the configuration file
    at the specified path is not found
    """

    def __init__(self, filepath, *args):
        super().__init__(args)
        self.filepath = filepath

    def __str__(self):
        return f'The configuration file at {self.filepath} was not found'

class ConfigurationFileNotLoaded(Exception):
    """
    This exception is raised when the configuration file
    at the specified path is not found
    """

    def __init__(self):
        super().__init__()

    def __str__(self):
        return f'The configuration file at {self.filepath} was not found'