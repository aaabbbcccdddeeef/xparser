using X.DocumentExtractService.Contract.Models;

namespace X.DocumentExtractService.Contract
{
    public class ExtractedResult
    {
        /// <summary>
        /// ����ͼƬ����
        /// </summary>
        public Picture[] Images
        {
            get;
            set;
        }

        public string Text
        {
            get;
            set;
        }
    }
}