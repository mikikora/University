import copy
import sys
from random import choice

debug = open('test.txt', 'w')

class Queue:
    def __init__(self):
        self.q = list()
    def push(self, x):
        self.q.append(x)
    def pop(self):
        x = self.q[0]
        self.q = self.q[1:]
        return x
    def __str__(self):
        return self.q.__str__()
    def empty(self):
        if self.q == []:
            return True
        else:
            return False


class Jungle(object):
    def __init__(self, player = 0, pieces = None):
        self.board = self.Initial_board()
        if pieces is None:
            self.pieces = self.Initial_pieces()
        else:
            self.pieces = pieces
        self.player = player
        self.last_beat = 0
        self.players_pieces = {0: ['r', 'c', 'd', 'w', 'j', 't', 'l', 'e'],
                          1: ['R', 'C', 'D', 'W', 'J', 'T', 'L', 'E']}
        self.hierarchy = {}
        i = 0
        for e in self.players_pieces[0]:
            self.hierarchy[e] = i
            i += 1
        i = 0
        for e in self.players_pieces[1]:
            self.hierarchy[e] = i
            i += 1

    def Initial_board(self):
        board = '''
        ..#*#..
        ...#...
        .......
        .~~.~~.
        .~~.~~.
        .~~.~~.
        .......
        ...#...
        ..#*#..
        '''
        return [list(e.strip()) for e in board.split()]

    def Initial_pieces(self):
        pieces = '''
        L.....T
        .D...C.
        R.J.W.E
        .......
        .......
        .......
        e.w.j.r
        .c...d.
        t.....l
        '''
        return [list(e.strip()) for e in pieces.split()]

    def find_piece(self, tpl):
        x, y = tpl
        return self.pieces[x][y]

    def find_place(self, piece):
        for i in range(len(self.pieces)):
            for j in range(len(self.pieces[i])):
                if self.pieces[i][j] == piece:
                    return (i, j)
        print(piece, self.pieces, file=debug)

    def Check_draw(self):
        if self.last_beat == 30:
            return True
        else:
            return False

    def Check_victory(self):
        if self.pieces[0][3] != '.':
            return 0
        elif self.pieces[8][3] != '.':
            return 1
        else:
            pieces_left = set()
            for i in range(len(self.pieces)):
                for j in range(len(self.pieces[i])):
                    if self.pieces[i][j] != '.':
                        pieces_left.add(self.pieces[i][j])
            if all(e not in pieces_left for e in self.players_pieces[0]):
                return '1 won'
            elif all(e not in pieces_left for e in self.players_pieces[1]):
                return '0 won'
            else:
                return False

    def Win_when_draw(self):
        player_0 = self.players_pieces[0]
        player_1 = self.players_pieces[1]
        player_1_have = set()
        player_0_have = set()
        for i in range(len(self.pieces)):
            for j in range(len(self.pieces[i])):
                if self.pieces[i][j] in player_0:
                    player_0_have.add(self.pieces[i][j])
                if self.pieces[i][j] in player_1:
                    player_1_have.add(self.pieces[i][j])
        player_0.reverse()
        player_1.reverse()
        i = 0
        while i < 8:
            if player_1[i] not in player_1_have and player_0[i] in player_0_have:
                return '0 won'
            if player_0[i] not in player_0_have and player_1[i] in player_1_have:
                return '1 won'
            i += 1
        return '1 won'

    def Where_I_land(self, start, move):
        x, y = start
        x1, y1 = move
        x += x1
        y += y1
        if x >= 9 or y >= 7 or x < 0 or y < 0:
            return False
        return (x,y)

    def Move_LorT(self, start, move):
        x, y = self.Where_I_land(start, move)
        if self.board[x][y] == '~':
            if self.pieces[x][y] != 'r' and self.pieces[x][y] != 'R':
                return self.Move_LorT((x,y), move)
            else: return None
        else:
            return (x,y)

    def moves(self, player):
        posible_moves = [(i, j) for i in [-1, 1, 0] for j in [-1, 1, 0] if
                         (i == 0 or j == 0) and not (i == 0 and j == 0)]
        pieces_to_move = self.players_pieces[player]
        res = {}
        for e in pieces_to_move:
            res[e] = set()
        for i in range(len(self.board)):
            for j in range(len(self.board[i])):
                if self.pieces[i][j] in pieces_to_move:
                    for e in posible_moves:
                        new_poz = self.Where_I_land((i,j), e)
                        if new_poz:
                            # print(new_poz)
                            x, y = new_poz
                            whereIland = self.board[x][y]
                            piece = self.pieces[i][j]
                            if whereIland == '.' or whereIland == '#':
                                if (piece == 'r' or piece == 'R') and ((self.board[i][j] == '~' and self.pieces[x][y] != '.') or (self.board[i][j] == '.' and self.board[x][y] == '~' and self.pieces[x][y] != '.')):
                                    pass
                                else:
                                    res[piece].add(new_poz)
                            elif whereIland == '*':
                                if player == 0 and i < 5:
                                    res[piece].add(new_poz)
                                elif player == 1 and i > 5:
                                    res[piece].add(new_poz)
                            elif whereIland == '~':
                                if piece == 'r' or piece == 'R':
                                    res[piece].add(new_poz)
                                '''if piece == 't' or piece == 'l':
                                    new_poz = self.Move_LorT((i,j), e, 'R')
                                    if new_poz is not None:
                                        res[piece].add(new_poz)
                                if piece == 'T' or piece == 'L':
                                    new_poz = self.Move_LorT((i, j), e, 'r')
                                    if new_poz is not None:
                                        res[piece].add(new_poz)'''
                                if piece == 't' or piece == 'T' or piece == 'l' or piece == 'L':
                                    new_poz = self.Move_LorT((i,j), e)
                                    if new_poz is not None:
                                        res[piece].add(new_poz)
        true_res = copy.deepcopy(res)
        for e in res:
            for f in res[e]:
                x1, y1 = f
                if self.pieces[x1][y1] != '.':
                    if self.pieces[x1][y1] in pieces_to_move:
                        true_res[e] -= set([f])
                    elif self.board[x1][y1] != '#':
                        if self.hierarchy[e] == 0 and self.hierarchy[self.pieces[x1][y1]] == 7:
                            pass
                        elif self.hierarchy[e] < self.hierarchy[self.pieces[x1][y1]]:
                            true_res[e] -= set([f])
        if all(true_res[e] == set() for e in true_res):
            return None
        for e in true_res:
            true_res[e] = list(true_res[e])
        return true_res

    def do_move(self, what, where):
        self.player = (self.player + 1) % 2
        if what == (-1, -1) and where == (-1,-1):
            return
        x,y = where
        x1, y1 = self.find_place(what)
        self.pieces[x1][y1] = '.'
        if self.pieces[x][y] != '.':
            self.last_beat = 0
        else:
            self.last_beat += 1
        self.pieces[x][y] = what
        if self.Check_victory() != False:
            return self.Check_victory().__str__()
        elif self.Check_draw():
            return self.Win_when_draw()
        else:
            return

    def rate_state(self, player):
        player_0 = self.players_pieces[0]
        player_1 = self.players_pieces[1]
        player_1_have = set()
        player_0_have = set()
        dist_0 = []
        dist_1 = []
        for i in range(len(self.pieces)):
            for j in range(len(self.pieces[i])):
                if self.pieces[i][j] in player_0:
                    player_0_have.add(self.pieces[i][j])
                    dist_0.append(i + abs(3 - j))
                if self.pieces[i][j] in player_1:
                    player_1_have.add(self.pieces[i][j])
                    dist_1.append(abs(8-i) + abs(3 - j))
        suma_0 = 0
        suma_1 = 0
        for e in player_0_have:
            suma_0 += self.hierarchy[e]
        for e in player_1_have:
            suma_1 += self.hierarchy[e]

        if player == 0:
            return suma_0 - suma_1 - (max(dist_0) if dist_0 != list() else 0)
        else:
            return suma_1 - suma_0 - (max(dist_1) if dist_1 != list() else 0)

class Player:
    def __init__(self):
        self.reset()

    def reset(self):
        self.game = Jungle()
        self.player = 1 # ustawie jak sie dowiem ktory jestem
        self.say('RDY')

    def say(self, what):
        sys.stdout.write(what)
        sys.stdout.write('\n')
        sys.stdout.flush()

    def hear(self):
        line = sys.stdin.readline().split()
        return line[0], line[1:]

    def rate_move(self):
        depth = 0
        q = Queue()
        my_moves = self.game.moves(self.player)
        for e in my_moves:
            for i in range(len(my_moves[e])):
                #print(self.game.pieces, file=debug)
                new_piece_board = [list() + e for e in self.game.pieces]
                g = Jungle(self.player, new_piece_board)
                vic = g.do_move(e, my_moves[e][i])
                q.push(((e, i), g, g.player, vic))
        while depth < 2000:
            parent, act_game, act_player, vic = q.pop()
            if vic:
                q.push((parent, act_game, act_player, vic))
            else:
                moves = act_game.moves(act_player)
                if moves is None:
                    act_game.do_move((-1, -1), (-1, -1))
                    q.push((parent, act_game, act_game.player, vic))
                else:
                    with_what = choice([e for e in moves])
                    while moves[with_what] == list():
                        with_what = choice([e for e in moves])
                    vic = act_game.do_move(with_what, choice(moves[with_what]))
                    q.push((parent, act_game, act_game.player, vic))
            depth += 1
        res = []
        while not q.empty():
            parent, act_game, act_player, vic = q.pop()
            if vic == '0 won' and self.player == 0:
                res.append((parent, 100+act_game.rate_state(0)))
            elif vic == '1 won' and self.player == 1:
                res.append((parent, 100 + act_game.rate_state(1)))
            elif vic == '0 won' and self.player == 1:
                res.append((parent, -100 + act_game.rate_state(1)))
            elif vic == '1 won' and self.player == 0:
                res.append((parent, -100 + act_game.rate_state(0)))
            else:
                res.append((parent, act_game.rate_state(self.player)))
        r = max(res, key=lambda x: x[1])[0]
        result = (r[0], my_moves[r[0]][r[1]])
        #print(result, file=debug)
        return result


    def loop(self):
        while True:
            cmd, args = self.hear()
            if cmd == 'HEDID':
                start = tuple(int(m) for m in args[2:4])
                ys, xs = start
                move = tuple(int(m) for m in args[4:])
                yd, xd = move
                self.game.do_move(self.game.find_piece((xs, ys)), (xd, yd))
            elif cmd == 'ONEMORE':
                self.reset()
                continue
            elif cmd == 'BYE':
                break
            else: # 'UGO'
                self.player = 0

            what, where = self.rate_move()
            xs, ys = self.game.find_place(what)
            xd, yd = where
            self.game.do_move(what, where)
            #print('IDO %d %d %d %d' % (ys, xs, yd, xd),file=debug)
            self.say('IDO %d %d %d %d' % (ys, xs, yd, xd))

if __name__ == '__main__':
    player = Player()
    player.loop()

debug.close()