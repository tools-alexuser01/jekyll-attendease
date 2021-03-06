# encoding: UTF-8
module Jekyll
  module AttendeasePlugin
    class Helpers
      def self.parameterize(source, sep = '_')
        return '' if source.nil?

        string = Helpers.convert_to_ascii(source.downcase)

        unless sep.nil? || sep.empty?
          # Turn unwanted chars into the separator
          string.gsub!(/[^a-z0-9]+/, sep)

          re_sep = Regexp.escape(sep)
          # No more than one of the separator in a row.
          string.gsub!(/#{re_sep}{2,}/, sep)
          # Remove leading/trailing separator.
          string.gsub!(/^#{re_sep}|#{re_sep}$/, '')
        end
        string
      end

      def self.convert_to_ascii(s)
        undefined = ''
        fallback = {'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ã' => 'A', 'Ä' => 'A',
                    'Å' => 'A', 'Æ' => 'AE', 'Ç' => 'C', 'È' => 'E', 'É' => 'E',
                    'Ê' => 'E', 'Ë' => 'E', 'Ì' => 'I', 'Í' => 'I', 'Î' => 'I',
                    'Ï' => 'I', 'Ñ' => 'N', 'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O',
                    'Õ' => 'O', 'Ö' => 'O', 'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U',
                    'Û' => 'U', 'Ü' => 'U', 'Ý' => 'Y', 'à' => 'a', 'á' => 'a',
                    'â' => 'a', 'ã' => 'a', 'ä' => 'a', 'å' => 'a', 'æ' => 'ae',
                    'ç' => 'c', 'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e',
                    'ì' => 'i', 'í' => 'i', 'î' => 'i', 'ï' => 'i', 'ñ' => 'n',
                    'ò' => 'o', 'ó' => 'o', 'ô' => 'o', 'õ' => 'o', 'ö' => 'o',
                    'ø' => 'o', 'ù' => 'u', 'ú' => 'u', 'û' => 'u', 'ü' => 'u',
                    'ý' => 'y', 'ÿ' => 'y' }
        s.encode('ASCII',
        fallback: lambda { |c| fallback.key?(c) ? fallback[c] : undefined })
      end

      def self.get_template(site, template_string)
        template = nil

        if site.config['attendease'] && templates = site.config['attendease']['templates']
          if t = templates.detect{|t| t['page'] == template_string}
            template = t['data']
          end
        end

        template
      end
    end
  end
end
