require File.join(File.expand_path(File.dirname(__FILE__)), 'support', 'spec_helper')
require 'assemblyinfotester'
require 'assemblyinfo'

describe AssemblyInfo, "when providing custom attributes" do
	
	before :all do
		@tester = AssemblyInfoTester.new
		asm = AssemblyInfo.new
		
		asm.custom_attributes :CustomAttribute => "custom attribute data", :AnotherAttribute => "more data here"

		asm.file = @tester.assemblyinfo_file
		asm.write
		@filedata = @tester.read_assemblyinfo_file
	end
	
	it "should write the custom attributes to the assembly info file" do
		@filedata.should include("[assembly: CustomAttribute(\"custom attribute data\")]")
		@filedata.should include("[assembly: AnotherAttribute(\"more data here\")]")
	end
end

describe AssemblyInfo, "when generating an assembly info file" do
	
	before :all do
		@tester = AssemblyInfoTester.new
		asm = AssemblyInfo.new
		
		asm.version = @tester.version
		asm.title = @tester.title
		asm.description = @tester.description
		
		asm.file = @tester.assemblyinfo_file
		asm.write
		@filedata = @tester.read_assemblyinfo_file
	end
	
	it "should use the system.reflection namespace" do
		@filedata.should include("using System.Reflection;")
	end
	
	it "should use the system.runtime.interopservices namespace" do
		@filedata.should include("using System.Runtime.InteropServices;")
	end
	
	it "should contain the specified version information" do
		@filedata.should include("[assembly: AssemblyVersion(\"#{@tester.version}\")]")
	end
	
	it "should contain the assembly title" do
		@filedata.should include("[assembly: AssemblyTitle(\"#{@tester.title}\")]")
	end
	
	it "should contain the assembly description" do
		@filedata.should include("[assembly: AssemblyDescription(\"#{@tester.description}\")]")
	end
	
end

describe AssemblyInfo, "when generating an assembly info file with no attributes provided" do
	
	before :all do
		@tester = AssemblyInfoTester.new
		asm = AssemblyInfo.new
		
		asm.file = @tester.assemblyinfo_file
		asm.write
		@filedata = @tester.read_assemblyinfo_file
	end
	
	it "should not contain the specified version information" do
		@filedata.should_not include("[assembly: AssemblyVersion(\"#{@tester.version}\")]")
	end
	
	it "should not contain the assembly title" do
		@filedata.should_not include("[assembly: AssemblyTitle(\"#{@tester.title}\")]")
	end
	
	it "should not contain the assembly description" do
		@filedata.should_not include("[assembly: AssemblyDescription(\"#{@tester.description}\")]")
	end
end
