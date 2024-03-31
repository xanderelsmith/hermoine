import 'dart:developer';
import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../domain/entities/geminiapihelper.dart';

class PdfQuizScreen extends ConsumerStatefulWidget {
  const PdfQuizScreen({Key? key, required this.pdf}) : super(key: key);
  final File pdf;
  @override
  ConsumerState<PdfQuizScreen> createState() => _PdfQuizScreenState();
}

class _PdfQuizScreenState extends ConsumerState<PdfQuizScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfDocument? _pdfDocument;
  bool isDropDown = true;
  int start = 0, end = 0;

  @override
  void initState() {
    super.initState();

    _loadPdf(); // Load the PDF initially
  }

  Future<void> _loadPdf() async {
    // Replace this with your actual PDF loading logic
    _pdfDocument = PdfDocument(inputBytes: widget.pdf.readAsBytesSync());

    setState(() {});
  }

  Future<void> _extractPages(screensize) async {
    final RangeValues selectedPages =
        RangeValues(start.toDouble(), end.toDouble());

    String extractedText = PdfTextExtractor(_pdfDocument!).extractText(
      startPageIndex: selectedPages.start.toInt(), // Indices are 0-based
      endPageIndex: selectedPages.end.toInt(),
    );
    if (extractedText.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text('No input text'),
              content: Text('There is no specified text')));
    } else {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Extracted text',
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(extractedText
                                .replaceAll(RegExp(r'\s+'), ' ')
                                .trim())),
                      )),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(screensize.width / 1.5, 30)),
                            onPressed: () async {
                              final gemini = Gemini.instance;
                              String quizdata = '';
                              log('generating');
                              gemini
                                  .text(GeminiSparkConfig.prompt(extractedText
                                      .replaceAll(RegExp(r'\s+'), ' ')
                                      .trim()))
                                  .then((value) {
                                log('result $value.output');
                              });
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SectionChat(
                              //               extractedText: extractedText
                              //                   .replaceAll(RegExp(r'\s+'), ' ')
                              //                   .trim(),
                              //             )));
                              // var extractedProcessedData =
                              //     QuestionExtractor(text: extractedText);
                              // var obtaineddata = extractedProcessedData
                              //     .extractQuestionsFullData();
                              // log(obtaineddata.toString());
                            },
                            child: const Text('Quizify')),
                      ),
                    ],
                  ),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(screensize.width / 1.2, 50)),
            onPressed: () {
              if (end - start < 4) {
                _extractPages(screensize);
              } else {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                        title: Text('Limited Page generation'),
                        content: Text(
                            'You are only allowed to generate quizes based on 3 pages maximum. Page generation above that comes at a cost. Contact us for enquiries')));
              }
            },
            child: const Text('Extract Pages')),
      ),
      bottomSheet: SizedBox(
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const Text('Start'),
              isDropDown == false
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: TextField(
                        onChanged: (onChangedVal) {
                          setState(() {
                            start = int.parse(onChangedVal);
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero),
                      ),
                    )
                  : DropdownButton<int>(
                      value: start,
                      items: List.generate(
                          _pdfDocument!.pages.count,
                          (index) => DropdownMenuItem(
                                value: index,
                                child: Text((index + 1).toString()),
                              )),
                      onChanged: (onChangedVal) {
                        setState(() {
                          start = onChangedVal ?? 0;
                        });
                      }),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isDropDown = !isDropDown;
                    });
                  },
                  icon: const Icon(Icons.swap_horiz_sharp)),
              const Text('End'),
              isDropDown == false
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (onChangedVal) {
                          setState(() {
                            end = int.parse(onChangedVal);
                          });
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            border: OutlineInputBorder()),
                      ),
                    )
                  : DropdownButton(
                      value: end,
                      items: List.generate(
                          _pdfDocument!.pages.count,
                          (index) => DropdownMenuItem(
                                value: index,
                                child: Text((index + 1).toString()),
                              )),
                      onChanged: (onChangedVal) {
                        setState(() {
                          end = onChangedVal ?? 0;
                        });
                      })
            ]),
            const Text('Hint: Page selection is limited to 3 in free tier')
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('PDF Quiz'),
      ),
      body: _pdfDocument != null
          ? SfPdfViewer.file(
              widget.pdf,
              key: _pdfViewerKey,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
