atom_feed do |feed|
  feed.title global_title
  feed.updated((@recipes.first.updated_at))

  @recipes.each do |recipe|
    feed.entry(recipe) do |entry|
      entry.title(recipe.title)
      entry.subtitle(recipe.description, type: 'text')
    end
  end
end
