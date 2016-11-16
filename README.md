##Letterwise Magic Squares

A quick attempt to find letterwise magic squares.

Letterwise magic squares are magic squares such that the count of letters of the
English words for the numbers in the square also form a magic square. This is
better explained in [this](https://www.youtube.com/watch?v=cZ1W1vbuYuQ)
standupmaths video.

This attempt uses [Sentient](http://sentient-lang.org/) which is a programming
language I've been writing for solving combinatorial problems. The program is
generalised and will work for squares of different dimensions. Additionally, it
is generalised to search for chains of letterwise magic squares of arbitrary
length.

Some Ruby is used for the dynamic generation of Sentient programs and there's
some bash to coordinate the whole thing. If you have a fairly recent version of
Ruby installed, you can run the program with `./run`. This starts a number of
processes to search in parallel. You can kill these processes with
`killall ruby`.

Much of this code is borrowed from
[this repository](https://github.com/tuzz/number_chains) where I tackled another
of standupmaths' problems. Some of the code is tested there, but this is mostly
just cobbled together in an hour or so.

##Solutions

**Chain length 2, Dimension 3:**

```
(sum: 45)
18, 22, 5
2, 15, 28
25, 8, 12
```

```
(sum: 21)
8, 9, 4
3, 7, 11
10, 5, 6
```

**Chain length 2, Dimension 4:**

```
(sum: 258)
18, 127, 105, 8
125, 1, 24, 108
4, 115, 118, 21
111, 15, 11, 121
```

```
(sum: 54)
8, 24, 17, 5
23, 3, 10, 18
4, 20, 21, 9
19, 7, 6, 22
```
