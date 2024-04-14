from collections import defaultdict

class CFG:
    def __init__(self, grammar):
        self.grammar = grammar
        self.non_terminals = set(grammar.keys())
        self.terminals = set(term for rhs in grammar.values() for prod in rhs for term in prod) - self.non_terminals
        self.first = self.calculate_first()
        self.follow = self.calculate_follow()
        self.table = self.build_table()

    def calculate_first(self):
        first = defaultdict(set)
        for non_terminal in self.non_terminals:
            self.first_of(non_terminal, first)
        return first

    def first_of(self, symbol, first):
        if symbol in self.terminals or symbol == 'ε':
            return {symbol}
        if symbol in first:
            return first[symbol]
        for production in self.grammar[symbol]:
            for term in production:
                first[symbol] |= self.first_of(term, first) - {'ε'}
                if 'ε' not in self.first_of(term, first):
                    break
            else:
                first[symbol].add('ε')
        return first[symbol]

    def calculate_follow(self):
        follow = defaultdict(set)
        follow[next(iter(self.grammar))].add('$')
        for non_terminal in self.non_terminals:
            self.follow_of(non_terminal, follow)
        return follow

    def follow_of(self, symbol, follow):
        if symbol not in self.non_terminals:
            return set()
        if symbol in follow and follow[symbol]:  # Add this check
            return follow[symbol]
        for non_terminal, productions in self.grammar.items():
            for production in productions:
                try:
                    position = production.index(symbol)
                    follow[symbol] |= set(term for prod in productions for term in prod[position+1:]) - self.non_terminals
                    if position == len(production) - 1 or 'ε' in self.first_of(production[position+1], self.first):
                        follow[symbol] |= self.follow_of(non_terminal, follow)
                except ValueError:
                    pass
        return follow[symbol]

    def build_table(self):
        table = defaultdict(dict)
        for non_terminal, productions in self.grammar.items():
            for production in productions:
                for term in self.first_of(production[0], self.first):
                    if term != 'ε':
                        table[non_terminal][term] = production
                if 'ε' in self.first_of(production[0], self.first):
                    for term in self.follow_of(non_terminal, self.follow):
                        table[non_terminal][term] = production
        return table

    def print_sets_and_table(self):
        print("FIRST sets:")
        for non_terminal, first_set in self.first.items():
            print(f"FIRST({non_terminal}) = {first_set}")
        print("\nFOLLOW sets:")
        for non_terminal, follow_set in self.follow.items():
            print(f"FOLLOW({non_terminal}) = {follow_set}")
        print("\nParsing table:")
        for non_terminal, row in self.table.items():
            for terminal, production in row.items():
                print(f"M[{non_terminal}, {terminal}] = {production}")

# Usage
grammar = {
    'E': [['T', "E'"]],
    "E'": [['+', 'T', "E'"], ['ε']],
    'T': [['F', "T'"]],
    "T'": [['*', 'F', "T'"], ['ε']]
}
cfg = CFG(grammar)
cfg.print_sets_and_table()