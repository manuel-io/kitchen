module ApplicationHelper

  def amount(val, unit)
    case unit
      when 'EL', 'TL'
        case val
          when 0.125  then '⅛'
          when 0.2 then '⅕'
          when 0.25 then '¼'
          when 0.4 then '⅖'
          when 0.5 then '½'
          when 0.6 then '⅗'
          when 0.75 then '¾'
          when 0.8 then '⅘'
          when 1..9 then number_with_precision(val, precision: 0)
          else number_with_precision(val, precision: 2)
        end
      else number_with_precision(val, precision: 0)
    end
  end

  def number(total)
    integer, fractional = ("%.2f" % total.to_f).split('.')
    t(:number_format, integer: integer, fractional: fractional)
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
