from custom_prompt import CustomPrompt


c = get_config()


c.TerminalInteractiveShell.prompts_class = CustomPrompt
c.TerminalInteractiveShell.separate_in = ""
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalIPythonApp.display_banner = False
