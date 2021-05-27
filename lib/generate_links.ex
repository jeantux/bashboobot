defmodule Bashboobot.GenerateLinks do
  def get_html(url) do
    case Tesla.get(url) do
      {:ok, data} -> data.body
      {_, _} -> ""
    end
  end

  def get_links(html) do
    {:ok, body} = Floki.parse_document(html)

    body
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.filter(fn s ->
      String.trim(s) != "" and String.starts_with?(s, "http")
    end)
    |> Enum.uniq()
  end

  def save_links(list_links, main_url) do
    name = Regex.run(~r/[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9](?:\.[a-zA-Z]{2,})+/, main_url)
    name_file = "output/#{name}"

    links_text = Enum.join(list_links, "\n")

    case File.write(name_file, links_text) do
      :ok -> "#{name_file} save with success"
      {_, reason} -> "fail to write file #{name_file}, #{reason}"
    end
  end

  def mining_content(list_links, main_url) do
    save_links(list_links, main_url)

    Enum.each(list_links, fn url ->
      url
      |> get_html
      |> get_links
      |> save_links(url)
    end)
  end

  def main do
    url = "https://stackoverflow.com/"
    get_html(url)
    |> get_links
    |> mining_content(url)
  end
end
