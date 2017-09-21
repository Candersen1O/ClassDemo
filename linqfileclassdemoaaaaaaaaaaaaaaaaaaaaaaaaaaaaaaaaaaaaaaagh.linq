<Query Kind="Statements">
  <Connection>
    <ID>34e49857-742e-4d0e-985f-27a711b93174</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>Chinook</Database>
  </Connection>
</Query>

var results=from x in Albums
			where x.ArtistId.Equals(90)
			select new {
				Title=x.Title,
				Released=x.ReleaseYear
			};
			results.Dump();