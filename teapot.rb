
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0"

define_target "jpeg" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "libjpeg-turbo-1.3.90")
		cache_prefix = Files::Directory.join(environment[:build_prefix], "libjpeg-turbo-1.3.90-#{environment.checksum}")
		package_files = Path.join(environment[:install_prefix], "lib/pkgconfig/libjpeg-turbo13.pc")

		cmake source: source_files, build_prefix: cache_prefix

		make prefix: cache_prefix, package_files: package_files
	end
	
	target.depends "Build/Files"
	target.depends "Build/CMake"
	
	target.depends :platform
	
	target.provides "Library/jpeg" do
		append linkflags "-ljpeg"
	end
end
