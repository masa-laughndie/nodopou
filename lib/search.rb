module Search
  def search_fields(*fields)
    @fields = valid_columns_from(fields)
  end

  def search(search_words)
    search_condition(search_words, @fields)
  end

  def search_condition(search_words, fields)
    condition = all
    return condition if search_words.blank?

    keywords = format(search_words)
    keywords.each do |keyword|
      where_phrases = [""]
      where_phrases = where_some_phrases_for(fields, keyword, where_phrases)

      condition = condition.where(where_phrases)
    end
    condition
  end

  private

  def valid_columns_from(fields)
    column_names.map(&:to_sym) & fields
  end

  def format(keywords)
    keywords.downcase.split(/[\s　]+/)
  end

  def where_some_phrases_for(fields, keyword, phrases)
    fields.each do |field|
      phrases[0] += "lower(#{field}) LIKE (?)"
      phrases[0] += " OR " if field != fields[-1]
      phrases << "%#{keyword}%"
    end
    phrases
  end
end