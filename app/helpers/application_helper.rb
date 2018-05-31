module ApplicationHelper

  def full_title(page_title = '')
    base_title = "nodopou ～シンプルNot-To-Doリスト～"
    if page_title.empty?
      base_title
    else
      page_title + "｜" + base_title
    end
  end

  def ogp_site_type(page_type = '')
    base_type = "article"
    if page_type.empty?
      base_type
    else
      page_type
    end
  end

  def ogp_image(page_image = '')
    base_image = "https://www.nodopou.com/images/ogp00.png"
    if page_image.empty?
      base_image
    else
      page_image
    end
  end

  def ogp_description(page_description = '')
    base_description = "シンプルな「やらない(Not-To-Do)」リストが簡単に作れるサービスです。" +
                       "Twitterで宣言することで実行度を上げたり、他の人の「やらない」に便乗できて、" +
                       "みんなで作業の効率化をはかれます。"
    if page_description.empty?
      base_description
    else
      page_description
    end
  end
  
end
