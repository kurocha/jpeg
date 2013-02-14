
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.6"

define_target "jpeg" do |target|
	target.install do |environment|
		install_external(package.path, "jpeg-8d", environment) do |config, fresh|
			if fresh
				Commands.run!("./configure",
					"--prefix=#{config.install_prefix}",
					"--disable-dependency-tracking",
					"--enable-shared=no",
					"--enable-static=yes",
					*config.configure
				)
			end
			
			Commands.make_install
		end
	end
	
	target.depends :platform
	
	target.provides "Library/jpeg" do
		append linkflags "-ljpeg"
	end
end
