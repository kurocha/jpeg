
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.5"

define_target "jpeg" do |target|
	target.install do |environment|
		environment.use in:(package.path + "jpeg-8d") do |config|
			Commands.run("make", "clean") if File.exist? "Makefile"
				
			Commands.run("./configure",
				"--prefix=#{config.install_prefix}",
				"--disable-dependency-tracking",
				"--enable-shared=no",
				"--enable-static=yes",
				*config.configure
			)
				
			Commands.run("make", "install")
		end
	end
	
	target.depends :platform
	
	target.provides "Library/jpeg" do
		append linkflags "-ljpeg"
	end
end
