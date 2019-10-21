class XpdfJimrafuse < Formula
  desc "PDF tools"
  homepage "http://www.foolabs.com/xpdf/"

  # JR: Cannot update to 4.02 as Qt requirement is baked in somewhere.

  url "https://xpdfreader-dl.s3.amazonaws.com/xpdf-4.01.01.tar.gz"
  sha256 "ba550c7d3e4f73b1833cfcdcd9dbe39849dd0cd459b6774c4ecdfeca993204a4"

  depends_on "cmake" => :build
  depends_on "freetype"

  conflicts_with "pdf2image", "poppler",
    :because => "xpdf, pdf2image, and poppler install conflicting executables"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    cp test_fixtures("test.pdf"), testpath
    assert_match "Pages:", shell_output("#{bin}/pdfinfo #{testpath}/test.pdf")
  end
end
