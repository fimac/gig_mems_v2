defmodule GigMemsV2.GigApi do
  def get_gig(artist \\ "", city \\ "", state \\ "", tour_name \\ "", venue_name \\ "") do
    api_key = setlistfm_api_key()

    HTTPoison.get(
      "https://api.setlist.fm/rest/1.0/search/setlists",
      ["x-api-key": api_key, Accept: "Application/json; Charset=utf-8"],
      params: %{
        artistName: artist,
        cityName: city,
        state: state,
        tour_name: tour_name,
        venue_name: venue_name
      }
    )
    |> handle_response()
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
