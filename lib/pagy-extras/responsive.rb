# See the Pagy Extras documentation: https://ddnexus.github.io/pagy/pagy-extras

require 'json'

class Pagy

  # default :breakpoints
  VARS[:breakpoints] = { 0 => [1,4,4,1] }

  # Helper for building the page_nav with javascript. For example:
  # with an object like:
  #   Pagy.new count:1000, page: 20, breakpoints: {0 => [1,2,2,1], 350 => [2,3,3,2], 550 => [3,4,4,3]}
  # it returns something like:
  #   { :items  => [1, :gap, 18, 19, "20", 21, 22, 50, 2, 17, 23, 49, 3, 16, 24, 48],
  #     :series => { 0   =>[1, :gap, 18, 19, "20", 21, 22, :gap, 50],
  #                  350 =>[1, 2, :gap, 17, 18, 19, "20", 21, 22, 23, :gap, 49, 50],
  #                  550 =>[1, 2, 3, :gap, 16, 17, 18, 19, "20", 21, 22, 23, 24, :gap, 48, 49, 50] },
  #     :widths => [550, 350, 0] }
  # where :items  is the unordered array union of all the page numbers for all sizes (passed to the PagyResponsive javascript function)
  #       :series is the hash of the series keyed by width (used by the *_responsive helpers to create the JSON string)
  #       :widths is the desc-ordered array of widths (passed to the PagyResponsive javascript function)
  def responsive
    @responsive ||= {items: [], series: {}, widths:[]}.tap do |r|
      @vars[:breakpoints].key?(0) || raise(ArgumentError, "expected :breakpoints to contain the 0 size; got #{@vars[:breakpoint].inspect}")
      @vars[:breakpoints].each {|width, size| r[:items] |= r[:series][width] = series(size)}
      r[:widths] = r[:series].keys.sort!{|a,b| b <=> a}
    end
  end

  # Add nav helpers for responsive pagination
  module Frontend

    # Generic responsive pagination: it returns the html with the series of links to the pages
    # we build the tags as a json object string and render them with the PagyResponsive javascript
    def pagy_nav_responsive(pagy, id=caller(1,1)[0].hash)
      tags = '{'; link = pagy_link_proc(pagy); responsive = pagy.responsive

      tags << (pagy.prev ? %('prev':'<span class="page prev">#{link.call pagy.prev, pagy_t('pagy.nav.prev'.freeze), 'aria-label="previous"'.freeze}</span> ',)
                         : %('prev':'<span class="page prev disabled">#{pagy_t('pagy.nav.prev'.freeze)}</span> ',))
      responsive[:items].each do |item|  # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
        tags << if    item.is_a?(Integer); %('#{item}':'<span class="page">#{link.call item}</span> ',)                    # page link
                elsif item.is_a?(String) ; %('#{item}':'<span class="page active">#{item}</span> ',)                       # current page
                elsif item == :gap       ; %('#{item}':'<span class="page gap">#{pagy_t('pagy.nav.gap'.freeze)}</span> ',) # page gap
                end
      end
      tags << (pagy.next ? %('next':'<span class="page next">#{link.call pagy.next, pagy_t('pagy.nav.next'.freeze), 'aria-label="next"'.freeze}</span>'})
                         : %('next':'<span class="page next disabled">#{pagy_t('pagy.nav.next'.freeze)}</span>'}))
      script = %(<script>PagyResponsive('#{id}', #{tags}, #{responsive[:widths].to_json}, #{responsive[:series].to_json});</script>)
      %(<nav id="pagy-nav-#{id}" class="pagy-nav-responsive pagination" role="navigation" aria-label="pager"></nav>#{script})
    end


    # Responsive pagination for bootstrap: it returns the html with the series of links to the pages
    # we build the tags as a json object string and render them with the PagyResponsive javascript
    def pagy_nav_bootstrap_responsive(pagy, id=caller(1,1)[0].hash)
      tags = '{'; link = pagy_link_proc(pagy, 'class="page-link"'.freeze); responsive = pagy.responsive

      tags << (pagy.prev ? %('prev':'<li class="page-item prev">#{link.call pagy.prev, pagy_t('pagy.nav.prev'.freeze), 'aria-label="previous"'.freeze}</li>',)
                         : %('prev':'<li class="page-item prev disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.prev'.freeze)}</a></li>',))
      responsive[:items].each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
        tags << if    item.is_a?(Integer); %('#{item}':'<li class="page-item">#{link.call item}</li>',)                                                               # page link
                elsif item.is_a?(String) ; %('#{item}':'<li class="page-item active">#{link.call item}</li>',)                                                        # active page
                elsif item == :gap       ; %('#{item}':'<li class="page-item gap disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.gap'.freeze)}</a></li>',) # page gap
                end
      end
      tags << (pagy.next ? %('next':'<li class="page-item next">#{link.call pagy.next, pagy_t('pagy.nav.next'.freeze), 'aria-label="next"'.freeze}</li>'})
                         : %('next':'<li class="page-item next disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.next'.freeze)}</a></li>'}))
      script = %(<script>PagyResponsive('#{id}', #{tags}, #{responsive[:widths].to_json}, #{responsive[:series].to_json});</script>)
      %(<nav id="pagy-nav-#{id}" class="pagy-nav-bootstrap-responsive pagination" role="navigation" aria-label="pager"><ul class="pagination"></ul></nav>#{script})
    end

  end
end
