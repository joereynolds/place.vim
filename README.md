# place.vim

place.vim allows you to add insertions to your text without moving your cursor.
If you suffer from the following problems, this plugin might be for you:

- Forgotten to add a ';' at the end of a line.
- Forgotten var, let, $ or any other variant at the beginning of a line.
- Wanted to insert some text without having to enter insert mode, move to the place, leave insert mode, and go back

![](https://i.imgur.com/pnmaJx9.gif)

## Why ga?

I think of it as (g)o (a)ppend.
That and `ga` by default is a pretty useless command that I thought people wouldn't mind losing.

### Remapping

If you don't like this mapping, you're always free to remap it
i.e.

```
nmap z <Plug>(place-insert)
```

## Examples

place.vim works in the 'vim' way. Here are a few examples of what it does


`|` denotes cursor position


### #1
```
function(na|me, $age)
gab$
```
Results in
```
function($name, $age)
```

### #2
```
$thi|s->doSomeStuff = 5
ga$;
```
Results in
```
$this->doSomeStuff = 5;
```

### #3

It also supports multiple line motions
```
This
is
a
really long
line
gaG.
```
Results in
```
This
is
a
really long
line.
```

### #4

A more complex motion (t)
```
T|his is Y sentence
gatYM
```
Results in
```
This is MY sentence
```

## FAQ

> I want to enter 'var' or 'let' like you said I could in the README!

Sure thing, you need to disable the default option, do this:

`let g:place_single_character_mode = 0`

Now, when you finish your motion, an input box will appear with what you want to insert.
This is turned off by default because I imagine the majority of people want to insert small things like $ or ;.
