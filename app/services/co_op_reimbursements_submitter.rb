require 'net/ftp'
require 'csv'

class CoOpReimbursementsSubmitter

  attr_reader :brand, :csv, :ftp_server

  def initialize(ftp_server, csv)
    @csv = csv
    @ftp_server = ftp_server
  end

  def execute
    convert_csv_delimiters
    upload_to_ftp
    verify_upload_success
  end

  private

  def convert_csv_delimiters
    CSV.open(tmp_file_path, 'a', col_sep: '|') do |pipe_delimited|
      original_csv.each do |row|
        row.map! { |r| r.try(:rstrip) }
        pipe_delimited << row
      end
    end
  end

  def upload_to_ftp
    Net::FTP.open(ftp_server.url, ftp_server.username, ftp_server.password) do |ftp|
      ftp.passive = true
      ftp.putbinaryfile(tmp_file_path, "/TEST/#{filename}")
      ftp.quit
    end
  end

  def original_csv
    @_original_csv ||= CSV.read(csv.tempfile)
  end

  def filename
    @_filename ||= "#{csv.original_filename.sub('.csv', Time.now.to_i.to_s)}.csv"
  end

  def tmp_file_path
    "#{Rails.root}/tmp/#{filename}"
  end

  def verify_upload_success
    Net::FTP.open(ftp_server.url, ftp_server.username, ftp_server.password) do |ftp|
      file_list = ftp.nlst("/TEST")
      if filename.in?(file_list)
        ftp.quit
        return true
      else
        ftp.quit
        return false
      end
    end
  end

end
