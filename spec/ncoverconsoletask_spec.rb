require File.join(File.expand_path(File.dirname(__FILE__)), 'support', 'spec_helper')
require 'ncoverconsole'
require 'ncoverconsoletask'
require 'tasklib_patch'

describe Albacore::NCoverConsoleTask, "when running" do
	before :all do
		Albacore::NCoverConsoleTask.new() do |t|
			@yielded_object = t
		end
	end
	
	it "should yield the ncover console api" do
		@yielded_object.kind_of?(NCoverConsole).should == true 
	end
end

describe Albacore::NCoverConsoleTask, "when execution fails" do
	before :all do
		@task = Albacore::NCoverConsoleTask.new(:failingtask)
		@task.extend(TasklibPatch)
		Rake::Task["failingtask"].invoke
	end
	
	it "should fail the rake task" do
		$task_failed.should == true
	end
end
