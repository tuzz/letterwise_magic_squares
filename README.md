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
processes to search in parallel. You'll also need Sentient.

Much of this code is borrowed from
[this repository](https://github.com/tuzz/number_chains) where I tackled another
of standupmaths' problems. Some of this code is tested, but it's mostly just
cobbled together in an hour or so.

##Solutions

Here's the solution presented in the standupmaths video:

```
(sum: 45)      (sum: 21)
18, 22, 5      8, 9, 4
2, 15, 28  =>  3, 7, 11
25, 8, 12      10, 5, 6
```

Here's a 4x4 solution:

```
(sum: 258)            (sum: 54)
18, 127, 105, 8       8, 24, 17, 5
125, 1, 24, 108   =>  23, 3, 10, 18
4, 115, 118, 21       4, 20, 21, 9
111, 15, 11, 121      19, 7, 6, 22
```

Here's a 3x3 solution that is **doubly letterwise**, meaning you can perform the
letterwise operation twice and both resulting squares are magic!

```
(sum: 434862830382)                           (sum: 354)         (sum: 60)
111954276794, 177773873377, 145134680211      112, 128, 105      19, 24, 17
178134680211, 144954276794, 111773873377  =>  108, 115, 122  =>  18, 20, 22
144773873377, 112134680211, 177954276794      125, 102, 118      23, 16, 21
```

Here's another. I'm yet to confirm what the smallest sum is for a 3x3 doubly
letterwise magic square.

```
(sum: 1107565022502)                          (sum: 345)         (sum: 60)
311648303290, 528682877879, 267233841333      105, 122, 118      17, 22, 21
324773878877, 369188340834, 413602802791  =>  128, 115, 102  =>  24, 20, 16
471142840335, 209693803789, 426728378378      112, 108, 125      19, 18, 23
```
