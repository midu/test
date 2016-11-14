defmodule Olympics.Multi do
  def get do
    multi_urls
    |> Enum.map(&Task.async(fn -> download_page(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.into(%{})
    |> Poison.encode!
  end

  defp multi_urls do
    %{
      google: "https://www.apple.com",
      apple: "https://www.apple.com",
      blue_apron: "https://www.blueapron.com"
    }
  end

  defp download_page({name, page}) do
    HTTPoison.start
    response = HTTPoison.get!(page)
    {name, response.body}
  end
end
