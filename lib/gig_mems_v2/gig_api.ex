defmodule GigMemsV2.GigApi do
  # def get_gig(artist \\ "", city \\ "", state \\ "", tour_name \\ "", venue_name \\ "") do
  def get_gig(artist, city \\ "") do
    api_key = setlistfm_api_key()

    HTTPoison.get(
      "https://api.setlist.fm/rest/1.0/search/setlists",
      ["x-api-key": api_key, Accept: "Application/json; Charset=utf-8"],
      params: %{
        artistName: artist,
        cityName: city
        # state: state,
        # tour_name: tour_name,
        # venue_name: venue_name
      }
    )
    |> handle_response()
  end

  def parse_response(%{setlist: setlist}) do
    setlist
    |> Enum.map(fn gig ->
      %{
        artist: gig.artist.name,
        date: gig.eventDate,
        # TODO: need to parse setlist more to get list. There might not always be a setlist.
        setlist: gig.sets.set,
        # TODO: tour_name: gig.tour.name, # there might not always be a tour name, handle this.
        venue: gig.venue.name,
        city: gig.venue.city.name,
        coords: gig.venue.city.coords
      }
    end)
  end

  defp handle_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Jason.decode!(body, keys: :atoms)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  defp setlistfm_api_key do
    Application.get_env(:gig_mems_v2, :setlist_fm_key)
  end
end
