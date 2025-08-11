enum ModelIA {
  gpt('openai/gpt-oss-20b:free'),
  deepSeek('tngtech/deepseek-r1t2-chimera:free'),
  gemmaFree('google/gemma-3-27b-it:free'),
  llama('meta-llama/llama-3.3-70b-instruct:free'),
  gemma3nE4Bit('gemma-3n-e4b-it');

  final String path;

  const ModelIA(this.path);
}