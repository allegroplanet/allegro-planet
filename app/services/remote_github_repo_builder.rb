class RemoteGithubRepoBuilder
  attr_reader :github_repo_url
  attr_reader :status
  attr_reader :log

  def initialize(github_repo_url: github_repo_url="https://github.com/MarkOates/allegro_flare.git")
    @github_repo_url = github_repo_url
    @log = []
  end

  def run_build
    clone
    make
    time_of_build
    create_zip
  ensure
    publish_log
  end

  private

  def publish_log
    # write the log to the Build
  end

  def clone
    append_log('Cloning repo')
    out, err, st = Open3.capture3("git clone #{github_repo_url.shellescape} #{clone_directory.to_s.shellescape}")
    append_log({out: out, err: err, st: st})
  end

  def make
    append_log('Initiating make')
    out, err, st = Open3.capture3("make --directory=#{clone_directory.to_s.shellescape}")
    append_log({out: out, err: err, st: st})
  end

  def create_zip
    Dir.mkdir(zip_destination_directory) unless File.exists?(zip_destination_directory)

    append_log('Creating zip file')
    ::Zip::File.open(zip_file_pathname, ::Zip::File::CREATE) do |zipfile|
      bin_folder_contents.each do |entry|
        zipfile.add(entry[:entry], entry[:local_source])
      end
    end
    append_log('Zip file created')
  end

  def zip_file_pathname
    Pathname.new(Rails.root.join(zip_destination_directory, zip_filename))
  end

  def zip_destination_directory
    Pathname.new(Rails.root.join('tmp', 'build-zips'))
  end

  def zip_filename
    "#{project_name}-#{build_id}-#{time_of_build}.zip"
  end

  def build_id
    'build-123456'
  end

  def time_of_build
    @time_of_build ||= Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def bin_folder_contents
    append_log('Reading project bin/ contents')
    bin_directories = Dir.glob(Rails.root.join(build_directory, '**', '*')).map do |path_element|
      zip_root_foldername = Pathname.new(project_name)
      pathname = Pathname.new(path_element)
      {
        entry: zip_root_foldername + pathname.relative_path_from(build_directory),
        local_source: pathname,
      }
    end
  end

  def build_directory
    Rails.root.join(clone_directory, 'bin')
  end

  def project_name
    github_repo_url.split('/').last.split('.').first
  end

  def clone_directory
    Rails.root.join('tmp', 'repos', sanitized_local_directory_name)
  end

  def sanitized_local_directory_name
    @sanitized_local_directory_name ||= begin
      fn = github_repo_url.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m
      fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }
      fn.join '.'
    end
  end

  def append_log(message)
    @log.push("[#{Time.zone.now}] #{message}")
  end
end
