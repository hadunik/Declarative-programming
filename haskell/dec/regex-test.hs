import Text.Regex.Posix

ext = "\\.txt$|\\.doc$"
filename = "test1.txt"
test = if (filename =~ ext) then "Ok" else "Wrong"

main = print test
