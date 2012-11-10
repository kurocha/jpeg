
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.1"

define_package "jpeg-8d" do |package|
	package.build(:all) do |platform, environment|
		environment.use in: package.source_path do |config|
			Commands.run("make", "clean") if File.exist? "Makefile"
				
			Commands.run("./configure",
				"--prefix=#{platform.prefix}",
				"--disable-dependency-tracking",
				"--enable-shared=no",
				"--enable-static=yes",
				*config.configure
			)
				
			Commands.run("make install")
		end
	end
end
