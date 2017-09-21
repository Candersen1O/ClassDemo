<Query Kind="Program">
  <Connection>
    <ID>34e49857-742e-4d0e-985f-27a711b93174</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>Chinook</Database>
  </Connection>
</Query>

void Main()
{
	var results=from x in Albums
			where x.ArtistId.Equals(90)
			select new artistalbumspocobyreleaseyear{
				Title=x.Title,
				Released=x.ReleaseYear
			};
			results.Dump();
}

// Define other methods and classes here
public class artistalbumspocobyreleaseyear
    {
        public string Title { get; set; }
        public int Released { get; set; }
    }