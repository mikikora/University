#!/usr/bin/env python
# -*- coding: UTF-8 -*-

from __future__ import absolute_import
from __future__ import print_function
from __future__ import unicode_literals


import random
import sys
import copy

debug = open('debug.txt', 'w')
class Reversi:
    M = 8
    DIRS = [(0, 1), (1, 0), (-1, 0), (0, -1),
            (1, 1), (-1, -1), (1, -1), (-1, 1)]

    def __init__(self):
        self.board = self.initial_board()
        self.fields = set()
        self.move_list = []
        self.history = []
        for i in range(self.M):
            for j in range(self.M):
                if self.board[i][j] is None:
                    self.fields.add((j, i))

    def initial_board(self):
        B = [[None] * self.M for _ in range(self.M)]
        B[3][3] = 1
        B[4][4] = 1
        B[3][4] = 0
        B[4][3] = 0
        return B

    def draw(self):
        for i in range(self.M):
            res = []
            for j in range(self.M):
                b = self.board[i][j]
                if b is None:
                    res.append('.')
                elif b == 1:
                    res.append('#')
                else:
                    res.append('o')
            print(''.join(res))
        print('')

    def moves(self, player):
        res = []
        for (x, y) in self.fields:
            if any(self.can_beat(x, y, direction, player)
                   for direction in self.DIRS):
                res.append((x, y))
        return res

    def can_beat(self, x, y, d, player):
        dx, dy = d
        x += dx
        y += dy
        cnt = 0
        while self.get(x, y) == 1 - player:
            x += dx
            y += dy
            cnt += 1
        return cnt > 0 and self.get(x, y) == player

    def get(self, x, y):
        if 0 <= x < self.M and 0 <= y < self.M:
            return self.board[y][x]
        return None

    def do_move(self, move, player):
        # print(player, len(self.move_list) % 2, file=debug)
        assert player == len(self.move_list) % 2
        self.history.append([x[:] for x in self.board])
        self.move_list.append(move)

        if move is None:
            return
        x, y = move
        x0, y0 = move
        self.board[y][x] = player
        self.fields -= set([move])
        for dx, dy in self.DIRS:
            x, y = x0, y0
            to_beat = []
            x += dx
            y += dy
            while self.get(x, y) == 1 - player:
                to_beat.append((x, y))
                x += dx
                y += dy
            if self.get(x, y) == player:
                for (nx, ny) in to_beat:
                    self.board[ny][nx] = player

    def result(self):
        res = 0
        for y in range(self.M):
            for x in range(self.M):
                b = self.board[y][x]
                if b == 0:
                    res -= 1
                elif b == 1:
                    res += 1
        return res

    def terminal(self):
        if not self.fields:
            return True
        if len(self.move_list) < 2:
            return False
        return self.move_list[-1] is None and self.move_list[-2] is None

    def move_history(self):
        return self.move_list


class Player(object):
    def __init__(self):
        self.reset()

    def reset(self):
        self.game = Reversi()
        self.my_player = 1
        self.moves = 0
        self.say('RDY')

    def say(self, what):
        sys.stdout.write(what)
        sys.stdout.write('\n')
        sys.stdout.flush()

    def hear(self):
        line = sys.stdin.readline().split()
        return line[0], line[1:]

    def h1(self, move):
        board = '''hTnvvnTh
TVttttVT
ntooootn
vtooootv
vtooootv
ntooootn
TVttttVT
hTnvvnTh
        '''
        rating = {}
        value = {'h':100,
                 'T':-20,
                 'n':10,
                 'v':5,
                 'V':50,
                 't':-2,
                 'o':-1,
                 '\n':None}
        for i in range(len(board.strip().split())):
            e = board.strip().split()[i]
            e.strip()
            # print(e, file=debug)
            for j in range(len(list(e))):
                rating[(i,j)] = value[e[j]]
        # print(rating, file=debug)
        return rating[move]

    def h2(self, game, new_game, player, move):
        m_player = len(game.moves(player))
        # print(len(game.move_history()) % 2, player, 'jestem w h2', file=debug)
        # game.do_move(move, player)
        m_opponent = len(new_game.moves(1 - player))
        c_player = 0
        c_opponent = 0
        for e in [(0,0), (7,7), (0,7), (7,0)]:
            whose = new_game.get(e[0], e[1])
            if whose is None:
                pass
            elif whose == player:
                c_player += 1
            else:
                c_opponent += 1
        return 10*(c_player - c_opponent) + (m_player - m_opponent) / (m_player + m_opponent)

    def h3(self, game, player, move):
        n_player = 0
        n_opponent = 0
        # game.do_move(move, player)
        for i in range(8):
            for j in range(8):
                whose = game.get(i,j)
                if whose is None:
                    pass
                elif whose == player:
                    n_player += 1
                else:
                    n_opponent += 1
        return n_player - n_opponent

    def choose_move(self, game, player, act_max=-100000, act_min=100000, depth=1):
        if depth == 0:
            res = {}
            moves = game.moves(player)
            # random.shuffle(moves)
            # print(len(game.move_history()) % 2, player, 'jestem w funckji', file=debug)
            for e in moves:
                new_game = Reversi()
                hisory = game.move_history()
                p = 0
                for e in hisory:
                    new_game.do_move(e, p)
                    p = 1 - p
                new_game.do_move(e, player)
                if self.moves < 15:
                    res[e] = self.h1(e)
                elif self.moves < 60:
                    res[e] = self.h2(game, new_game, player, e)
                else:
                    res[e] = self.h3(new_game, player, e)
            if res != {}:
                w = (max(res, key=lambda x: res[x]) if player == self.my_player else min(res, key=lambda x: res[x]))
                return w, res[w]
            else:
                return None, (-1000 if player == self.my_player else 10000)
        else:
            res = None
            resw = (-1000 if player == self.my_player else 10000)
            moves = game.moves(player)
            random.shuffle(moves)
            for f in moves:
                new_game = Reversi()
                hisory = game.move_history()
                p = 0
                for e in hisory:
                    new_game.do_move(e, p)
                    p = 1 - p
                # print(p, player, file=debug)
                new_game.do_move(f, player)
                m, w = self.choose_move(new_game, 1 - player, act_max, act_min, depth - 1)
                # print(m, w, act_max, file=debug)
                if player == self.my_player:
                    if w > act_max:
                        act_max = w
                        res = f
                        resw = w
                    if w < act_min:
                        continue
                if player != self.my_player:
                    if w < act_min:
                        act_min = w
                        res = f
                        resw = w
                    if w > act_max:
                        continue
            # print(res, resw, file=debug)
            return res, resw


    def loop(self):
        while True:
            cmd, args = self.hear()
            if cmd == 'HEDID':
                unused_move_timeout, unused_game_timeout = args[:2]
                move = tuple((int(m) for m in args[2:]))
                if move == (-1, -1):
                    move = None
                self.game.do_move(move, 1 - self.my_player)
                self.moves += 1
            elif cmd == 'ONEMORE':
                self.reset()
                continue
            elif cmd == 'BYE':
                break
            else:
                assert cmd == 'UGO'
                assert not self.game.move_list
                self.my_player = 0
####################################################################################
            # moves = self.game.moves(self.my_player)
            # if moves:
            #     move = random.choice(moves)
            #     self.game.do_move(move, self.my_player)
            # else:
            #     self.game.do_move(None, self.my_player)
            #     move = (-1, -1)

###################################################################################
            move, rating = self.choose_move(self.game, self.my_player)
            self.moves += 1
            self.game.do_move(move, self.my_player)
            # print(self.moves, file=debug)
            if move is None:
                move = (-1,-1)
            self.say('IDO %d %d' % move)


if __name__ == '__main__':
    player = Player()
    player.loop()
debug.close()
