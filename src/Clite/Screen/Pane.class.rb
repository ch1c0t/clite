attr_accessor :name, :range, :element

def render size
  rows_size = if range.last.positive?
                range.size
              else
                (range.first...(size.rows-1)).size
              end
  element.render rows_size
end
