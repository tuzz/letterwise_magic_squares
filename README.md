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

All of the magic squares listed here use this convention:

> one hundred _and_ twenty seven

##Solutions

Here's the solution presented in the standupmaths video:

```
(sum: 45)      (sum: 21)
18, 22, 5      8, 9, 4
2, 15, 28  =>  3, 7, 11
25, 8, 12      10, 5, 6
```

Here's the smallest possible 4x4 solution:

```
(sum: 258)            (sum: 54)
18, 127, 105, 8       8, 24, 17, 5
125, 1, 24, 108   =>  23, 3, 10, 18
4, 115, 118, 21       4, 20, 21, 9
111, 15, 11, 121      19, 7, 6, 22
```

Here's the smallest possible 3x3 solution that is doubly letterwise. This means
you can perform the letterwise operation twice and both resulting squares are
magic!

```
(sum: 303370120164)                          (sum: 345)         (sum: 60)
148728378378, 28372868903, 126268872883      125, 102, 118      23, 16, 21
78663867893, 101123373388, 123582878883  =>  108, 115, 122  =>  18, 20, 22
75977873893, 173873877873, 53518368398       112, 128, 105      19, 24, 17
```

There are more 3x3 doubly letterwise solutions [here](./doubly_letterwise.md).
It took about 3 days of compute time on my laptop for Sentient to find the
minimum solution.

There is a list of all 3x3 letterwise solutions up to 1000
[here](solutions_up_to_1000.md). There are 102 distinct solutions.
