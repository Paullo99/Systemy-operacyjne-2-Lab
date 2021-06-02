"""
Systemy Operacyjne 2
Lab05 - Kółko i krzyżyk
Paweł Maciończyk, 248837
"""
import os
import random
import time


def start_game():
    """
    Funkcja inicjalizująca grę, jej zadaniem jest wyświetlenie
    podstawowych informacji oraz poproszenie użytkownika o wybranie
    swojego znaku.
    :return: symbol gracza oraz symbol komputera w danej rozgrywce
    """
    print("\n ----------- KÓŁKO I KRZYŻYK -----------")
    print("Pola na planszy oznaczone są w następujący sposób")
    print('''
           0  |  1  |  2
          -----------------
           3  |  4  |  5
          -----------------
           6  |  7  |  8 \n
        ''')
    sign = input("Wybierz swój znak - X zaczyna: (O lub X) ")
    if sign in ("X", "x"):
        player_symbol = "X"
        computer_symbol = "O"
    else:
        player_symbol = "O"
        computer_symbol = "X"
    return player_symbol, computer_symbol


def clear_screen():
    """
    Funkcja odpowiada za czyszczenie konsoli w zależności od systemu operacyjnego.
    """
    os.system("cls" if os.name == "nt" else "clear")


class TicTacToe:
    """
    Klasa reprezentująca grę w kółko i krzyżyk
    """

    def __init__(self):
        self.player_symbol, self.computer_symbol = start_game()
        clear_screen()
        self.board = '''
           {0}  |  {1}  |  {2}
          -----------------
           {3}  |  {4}  |  {5}
          -----------------
           {6}  |  {7}  |  {8}
        '''
        self.game_status = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        self.possible_moves = [0, 1, 2, 3, 4, 5, 6, 7, 8]
        self.winner_options = ((0, 3, 6), (1, 4, 7), (2, 5, 8), (0, 1, 2), (3, 4, 5), (6, 7, 8),
                               (0, 4, 8), (6, 4, 2))
        self.winner = None

    def display_current_board(self):
        """
        Wyświetlanie aktualnej sytuacji na planszy w konsoli
        """
        print(self.board.format(*self.game_status))

    def check_if_game_end(self):
        """
        Funkcja sprawdzająca, czy sytuacja na planszy oznacza koniec meczu
        :return: True - jeśli koniec meczu, False - jeśli nadal trwa
        """
        for opt in self.winner_options:
            if self.game_status[opt[0]] == self.game_status[opt[1]] == self.game_status[opt[2]] \
                    == self.computer_symbol:
                self.winner = "Komputer wygrał!"
                return True
            if self.game_status[opt[0]] == self.game_status[opt[1]] == self.game_status[opt[2]] \
                    == self.player_symbol:
                self.winner = "Wygrałeś!"
                return True
            if len(self.possible_moves) == 0:
                return True
        return False

    def make_move(self):
        """
        Wykonanie ruchu przez użytkownika
        """
        choice = input("Twój ruch, wybierz pole (np. 0): ")
        try:
            square_number = int(choice)

            if square_number in self.possible_moves:
                self.game_status[square_number] = self.player_symbol
                self.possible_moves.remove(square_number)
            else:
                print("Wybrano nieprawidłowe pole! Spróbuj jeszcze raz")
                self.make_move()

        except ValueError:
            self.make_move()

    def computer_move(self):
        """
        Wykonanie ruchu przez komputer
        """
        print("Ruch komputera...")
        time.sleep(2)

        # Jako pierwszy ruch zawsze sprawdzane jest środkowe pole
        if 4 in self.possible_moves:
            self.game_status[4] = self.computer_symbol
            self.possible_moves.remove(4)

        else:
            # Komputer wykonuje ruch wygrywający
            for opt in self.winner_options:
                if self.game_status[opt[0]] == self.game_status[opt[1]] == self.computer_symbol \
                        and opt[2] in self.possible_moves:
                    self.game_status[opt[2]] = self.computer_symbol
                    self.possible_moves.remove(opt[2])
                    return

                if self.game_status[opt[0]] == self.game_status[opt[2]] == self.computer_symbol \
                        and opt[2] in self.possible_moves:
                    self.game_status[opt[1]] = self.computer_symbol
                    self.possible_moves.remove(opt[1])
                    return

                if self.game_status[opt[1]] == self.game_status[opt[2]] == self.computer_symbol \
                        and opt[0] in self.possible_moves:
                    self.game_status[opt[0]] = self.computer_symbol
                    self.possible_moves.remove(opt[0])
                    return

            # Komputer wykonuje ruch uniemożliwiający wygraną przeciwnika
            for opt in self.winner_options:
                if self.game_status[opt[0]] == self.game_status[opt[1]] == self.player_symbol \
                        and opt[2] in self.possible_moves:
                    self.game_status[opt[2]] = self.computer_symbol
                    self.possible_moves.remove(opt[2])
                    return

                if self.game_status[opt[0]] == self.game_status[opt[2]] == self.player_symbol \
                        and opt[1] in self.possible_moves:
                    self.game_status[opt[1]] = self.computer_symbol
                    self.possible_moves.remove(opt[1])
                    return

                if self.game_status[opt[1]] == self.game_status[opt[2]] == self.player_symbol \
                        and opt[0] in self.possible_moves:
                    self.game_status[opt[0]] = self.computer_symbol
                    self.possible_moves.remove(opt[0])
                    return

            # W ostateczności komputer wykonuje losowy ruch
            move = random.choice(self.possible_moves)
            self.game_status[move] = self.computer_symbol
            self.possible_moves.remove(move)

    def play(self):
        """
        Główna pętla odpowiadająca za rozgrywkę (na zmianę gracza oraz komputera).
        """
        if self.computer_symbol == "X":
            self.computer_move()

        while True:
            self.display_current_board()
            self.make_move()

            if self.check_if_game_end():
                break

            clear_screen()

            self.display_current_board()
            self.computer_move()

            if self.check_if_game_end():
                break

            clear_screen()

        clear_screen()
        self.display_current_board()
        if self.winner is None:
            print("\nREMIS!")
        else:
            print(self.winner)
        input("Wciśnij ENTER aby zakończyć!")


if __name__ == '__main__':
    t = TicTacToe()
    t.play()
