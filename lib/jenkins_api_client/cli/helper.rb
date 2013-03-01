#
# Copyright (c) 2012-2013 Kannan Manickam <arangamani.kannan@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require 'fileutils'

module JenkinsApi
  module CLI
    class Helper
      def self.setup(options)
        if options[:username] && options[:server_ip] && \
          (options[:password] || options[:password_base64])
          creds = options
        elsif options[:creds_file]
          creds = YAML.load_file(
            File.expand_path(options[:creds_file], __FILE__)
          )
        elsif File.exist?("#{ENV['HOME']}/.jenkins_api_client/login.yml")
          puts "Loading credentials from file!"
          creds = YAML.load_file(
            File.expand_path(
              "#{ENV['HOME']}/.jenkins_api_client/login.yml", __FILE__
            )
          )
        else
          msg = "Credentials are not set. Please pass them as parameters or"
          msg << " set them in the default credentials file"
          puts msg
          exit 1
        end
        puts creds
        JenkinsApi::Client.new(creds)
      end
    end
  end
end
