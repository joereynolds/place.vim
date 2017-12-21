# place.vim

place.vim allows you to add insertions to your text without moving your cursor.
If you suffer from the following problems, this plugin might be for you:

- Forgotten to add a ';' at the end of a line.
- Forgotten var, let, $ or any other variant at the beginning of a line.
- Wanted to insert some text without having to enter insert mode, move to the place, leave insert mode, and go back

Look no further!

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
