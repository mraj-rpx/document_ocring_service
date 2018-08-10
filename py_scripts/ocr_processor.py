class OcrProcessor:
    def initialize():


if __name__ == '__main__':
    ocr_processors_kalss = [LitDocumentOcrProcessor, PtabOcrProcessor]
    with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_WORKERS) as process_pool:
        klass_init = [klass() for klass in ocr_processors_kalss]
        for klass in
