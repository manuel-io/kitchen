atom_feed do |feed|
  feed.title global_title
  feed.updated((@recipes.first.updated_at))

  @recipes.each do |recipe|
    feed.entry(recipe, url: url_for(action: 'embedded', controller: 'recipes', id: recipe.id, only_path: false)) do |entry|
      entry.title recipe.title
      entry.subtitle(recipe.description, type: 'text')
    end
  end
end
