class IconsController < ApplicationController

  def star
    pct = params[:pct].to_i

    empty = pct ==   0
    full  = pct == 100

    off = '#ddd'
    on  = '#F47645'

    if full || empty
      defs = ''
    else
      defs = <<-SVG
        <defs>
          <linearGradient id="gradient" x1="0" x2="1" y1="1" y2="1">
            <stop stop-color="#{on}" offset="0%" />
            <stop stop-color="#{on}" offset="#{pct}%" />
            <stop stop-color="#{off}" offset="#{pct}%" />
            <stop stop-color="#{off}" offset="100%" />
          </linearGradient>
        </defs>
      SVG
    end

    if full
      fill = on
    elsif empty
      fill = off
    else
      fill = "url(#gradient)"
    end

    star_icon = <<-SVG
      <svg xmlns="http://www.w3.org/2000/svg" width="240" height="225" viewBox="0 0 48 45">
        <title>Star</title>
        #{defs}
        <path
           d="m 24,0 6,17 H 48 L 34,28 39,45 24,35 9,45 14,28 0,17 h 18 z"
           id="star"
           fill="#{fill}"
        />
      </svg>
    SVG

    respond_to do |format|
      format.svg { render inline: star_icon }
    end

  end

end
