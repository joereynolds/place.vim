# place.vim

place.vim allows you to add insertions to your text without moving your cursor.
If you suffer from the following problems, this plugin might be for you:

- Forgotten to add a ';' at the end of a line.
- Forgotten var, let, $ or any other variant at the beginning of a line.
- Wanted to insert some text without having to enter insert mode, move to the place, leave insert mode, and go back

![](https://i.imgur.com/N3rcDUi.gif)

## Mapping

Add a mapping of your choice to get place.vim working for you.

Example:

```
nmap ga <Plug>(place-insert)
nmap gb <Plug>(place-insert-multiple)
```

## Examples

(Examples are using `ga` as the prefix key but it can be anything you want)

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

Sure thing, there's a separate mapping `<Plug>(place-insert-multiple)` to map to.
Read the docs.

Now, when you finish your motion, an input box will appear with what you want to insert.
