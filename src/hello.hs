-- hello.hs

Import Html

main :: IO ()
main = putStrLn (render myhtml) 

myhtml :: Html
myhtml = 
    html_ "Hello title" 
        (append_ (h1_ "Heading") (append_ (p_ "Paragraph #1") (p_ "Paragraph #2")))
