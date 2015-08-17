# Search places in Hamburg

Using the [documentation](http://9flats.github.io/api_docs/v4/search_places.html)
write a small ruby script to search places in Hamburg.

The script should check every photo of each place
and return an array of photo URLs sorted by photo size in bytes.

## Notes

This code uses system call to `curl` in order to simplify HTTP headers extraction.
Makes sure you have it installed in your environment.

## Todo

- pagination is missing, sorry
