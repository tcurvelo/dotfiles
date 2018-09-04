from IPython.terminal.prompts import Prompts
from IPython.terminal.prompts import Token


class CustomPrompt(Prompts):

    def in_prompt_tokens(self, cli=None):
        return [(Token.Prompt, '>>> '), ]

    def out_prompt_tokens(self, cli=None):
        return [(Token.Prompt, ''), ]

    def continuation_prompt_tokens(self, cli=None, width=None):
        return [(Token.Prompt, ''), ]
