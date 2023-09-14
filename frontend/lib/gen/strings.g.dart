/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 270 (135 per locale)
///
/// Built on 2023-09-13 at 07:59 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	zhCn(languageCode: 'zh', countryCode: 'CN', build: _StringsZhCn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsAppEn app = _StringsAppEn._(_root);
	late final _StringsHomeEn home = _StringsHomeEn._(_root);
	late final _StringsChatEn chat = _StringsChatEn._(_root);
	late final _StringsTranslateEn translate = _StringsTranslateEn._(_root);
	late final _StringsWriteEn write = _StringsWriteEn._(_root);
	late final _StringsDocumentEn document = _StringsDocumentEn._(_root);
	late final _StringsTaskEn task = _StringsTaskEn._(_root);
}

// Path: app
class _StringsAppEn {
	_StringsAppEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Flutter-ChatGPT';
	String get error => 'An error occurs';
	String get more => 'more';
	String get edit => 'edit';
	String get delete => 'delete';
	String get cancel => 'cancel';
	String get confirm => 'confirm';
	String get clear => 'Clean';
	String get text_field_hint => 'Ask me anything...';
	String get big_text => 'Thanks to the high-quality feedback from Flutter users, in this release we have continued to improve the performance of Impeller on iOS. As a result of many different optimizations, the Impeller renderer on iOS now not only has lower latency (by completely eliminating shader compilation jank), but on some benchmarks also have higher average throughput. In particular, on our flutter/gallery transitions performance benchmark, average frame rasterization time is now around half of what it was with Skia';
}

// Path: home
class _StringsHomeEn {
	_StringsHomeEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get drawer_subtitle => 'CHANGE · ACTION · CONSENSUS';
	String get appbar_action => 'Embracing Tech · Creating Future';
	String get content_action => 'Processing...';
}

// Path: chat
class _StringsChatEn {
	_StringsChatEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get menuName => 'AI-Conversation';
	String get default_tip => 'Hi, I\'m AI Assistant, just ask me if you have any questions...';
	String get create_chat => 'Create Chat';
	String get create_chat_title => 'New Chat';
	String get prompt => 'Prompt';
	String get edit_prompt => 'Edit Prompt';
	String get edit_prompt_hint => 'Please enter the prompt name';
	String get chat_prompt_topic1 => 'Text Summary';
	String get chat_prompt_topic2 => 'Xiaohongshu\nBlogger';
	String get chat_prompt_topic3 => 'Writing\nAssistant';
	String get chat_prompt_topic4 => 'Weekly\nGeneration';
	String get chat_prompt_topic5 => 'Mind Map';
	String get chat_prompt_topic6 => 'Job Interview';
	String get chat_prompt_topic7 => 'Motivational\nSpeeches';
	String get chat_prompt_topic8 => 'Private Chef';
	String get chat_prompt_topic9 => 'Social Media';
	String get chat_prompt_topic10 => 'Business Plan';
	String get chat_prompt_topic11 => 'English\nLearning';
	String get chat_prompt_topic12 => 'Fitness\nInstructor';
	String get chat_prompt_content1 => 'Are you able to summarize the text I have provided and express it in up to 4-8 words? No additional input is required. If you are ready, please respond, "Yes, please provide the text"';
	String get chat_prompt_content2 => 'You are a stylish and super cute 20 year old girl 🦄 who now needs to create a funny and engaging article based on 📝. Each sentence should be filled with your favorite Emoji emoji 😍 and unleash your inner sparkle! Don\'t forget to add the #hashtag about the topic at the end! 💭 If you\'re ready, let me know "Yes, please provide the theme for the creation".';
	String get chat_prompt_content3 => 'As a Writing Improvement Assistant, your task is to improve the spelling, grammar, clarity, conciseness, and overall readability of the provided text while breaking up long sentences, reducing repetition, and providing suggestions for improvement. Please provide only the corrected Chinese version and avoid including explanations. If you are ready, please reply: ",OK, please enter the article that needs improvement."';
	String get chat_prompt_content4 => 'You need to generate a concise markdown format weekly summary that highlights the most important content, is easy for the general audience to read and understand, and provides insights and analysis useful to stakeholders and decision makers. You are free to use any additional information or sources. If you are ready, please answer, "Yes, please provide the topic for which the weekly report needs to be generated."';
	String get chat_prompt_content5 => 'Generate and respond to a Markdown-formatted mind map in the current language as required. Do not include any descriptions other than markdown in your response, and make sure it is formatted correctly. If you are ready, please reply with "Yes, please provide your topic."';
	String get chat_prompt_content6 => 'As the interviewing personnel director, you will need to list the skills and experience required for a job title and determine which questions the candidate will need to answer. If you are ready, answer, "Yes, please tell me the job title."';
	String get chat_prompt_content7 => 'You will take on the role of a motivational speaker, aiming to inspire people to try things beyond their capabilities through words that inspire action. You will talk about a variety of topics, but your goal is to make sure that what is said resonates with your audience and inspires them to strive for their own goals and pursue better possibilities. If you\'re ready, respond with, "Yes, please provide a topic for the presentation."';
	String get chat_prompt_content8 => 'I need you to play the role of my personal chef, understand my dietary preferences and allergies, and advise me on suitable recipes. Please reply only with the recipes you recommend and do not include any explanations. If you are ready, please reply, "Yes, please provide your dietary preferences."';
	String get chat_prompt_content9 => 'You need to play the role of a social media influencer by developing different promotional strategies and content for different platforms (e.g. WeChat, Weibo, Jieyin, Zhihu, Xiaohongshu, etc.) and interacting with your followers to increase brand awareness and promote your products or services. If you are ready, please answer, "Yes, let\'s get started."';
	String get chat_prompt_content10 => 'You need to generate ideas that are suitable for startups based on people\'s needs. For example, when I propose [business plan objective], you need to generate a business plan for the startup, including the idea name, a short one-sentence description, the target user persona, user pain points to be solved, key value propositions, sales and marketing channels, revenue streams, cost structure, key activities, key resources, key partners, idea validation steps, estimated first year of operation costs, and possible business challenges, and present the results in a Markdown table. If you are ready, please answer, ",Okay, please tell me what your business plan objectives are?"';
	String get chat_prompt_content11 => 'I need you to act as an English speaking teacher and improver to practice my speaking by communicating in English. You need to answer my questions in simple language and limit your responses to 100 words or less. You should strictly correct my grammatical errors, misspellings and factual errors and ask me a question in your response. Now we can start practicing and you can start by asking me a question. Remember, I expect you to strictly correct my grammatical errors, misspellings and factual errors. If you are ready, please answer, "Sure, let us go to started"';
	String get chat_prompt_content12 => 'I need you to take on the role of a personal trainer. I will provide you with all the information you need for a person who wants to become healthier, stronger and more energetic through physical training and it will be your role to develop the best program for that person based on their current fitness level, goals and lifestyle habits. You should utilize your knowledge of exercise science, nutritional advice, and other relevant factors in order to tailor a program that is right for them. If you are ready, please answer, "Yes, please provide basic information about your fitness level"';
}

// Path: translate
class _StringsTranslateEn {
	_StringsTranslateEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get menuName => 'AI-Translate';
	String get translate_failure => 'Translate failure';
	String get translate_tip => 'Translate';
	String get translate_start => 'Start Translate';
	String get translate_check_empty => 'Please input content to be translated';
	String get translate_check_type => 'Please select the correct translation language';
	String get language_native_zh => 'Chinese';
	String get language_native_ru => 'Russian';
	String get language_native_en => 'English';
	String get language_native_de => 'German';
	String get language_native_fr => 'French';
	String get language_native_ja => 'Japanese';
	String get language_native_ko => 'Korean';
}

// Path: write
class _StringsWriteEn {
	_StringsWriteEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get menuName => 'AI-Write';
	String get prompt_title => 'Generate Content Template';
	String get prompt_topic => 'Prompt Topic';
	String get prompt_tip => 'prompt content';
	String get prompt_system => 'You are a very efficient business office assistant tool and I will be asking you questions about it!';
	String get generate_loading => 'generate loading...';
	String get generate_finished => 'generate finished';
	String get generate_content_ai => 'AI Generate Text';
	String get copy_success => 'Copy Success';
	String get copy => 'Copy';
	String get wait_execute => 'Wait execute [Start Generate]...';
	String get start_generate => 'Start Generate';
	String get reset_template => 'Reset';
	String get system_role_tip => 'Please input a description of the content you need the system to play a role in';
	String get system_prompt_tip => 'Please input the prompt for which you want the system to generate an answer.';
	String get check_template_tip => 'Please input template parameters';
	String get prompt_name => 'Prompt Name';
	String get workspace => 'WorkSpace';
	String get prompt_space => 'Prompt Template';
	String get generate_content => 'Generative Text';
	String get write_prompt_title1 => 'Job Description';
	String get write_prompt_title2 => 'ChatGPT Training';
	String get write_prompt_title3 => 'Paragraph Summaries';
	String get write_prompt_title4 => 'Meeting Summaries';
	String get write_prompt_title5 => 'Text Extraction';
	String get write_prompt_title6 => 'Project Plan';
	String get write_prompt_title7 => 'Product Document';
	String get write_prompt_content1 => 'Help you to write a job description';
	String get write_prompt_content2 => 'Help you to write a ChatGPT training plan';
	String get write_prompt_content3 => 'Helps you write paragraph text summaries';
	String get write_prompt_content4 => 'Helping you write meeting summaries';
	String get write_prompt_content5 => 'Extract keyword information for you';
	String get write_prompt_content6 => 'Help you write a project plan';
	String get write_prompt_content7 => 'Help you write a product requirements document';
	String get write_prompt_label => 'Text Generate';
	String get write_prompt_topic1 => 'JD';
	String get write_prompt_topic2 => 'Training';
	String get write_prompt_topic3 => 'Summeries';
	String get write_prompt_topic4 => 'Summeries';
	String get write_prompt_topic5 => 'Keyword';
	String get write_prompt_topic6 => 'Project Plan';
	String get write_prompt_topic7 => 'PRD Doc';
	String get write_prompt_1 => 'Please generate a job posting for Android Development Engineer with 3-5 years of experience, responsible for merchant ordering Flutter App application development\n1.Job format: Boss Direct Recruitment Format, do not return boss direct recruitment associated text\n2.Job ending: 发出真诚邀请并附带hr@manna.com邮箱';
	String get write_prompt_2 => 'Please generate a ChatGPT offline training program, the content of the program contains \n1. for the company\'s middle and senior leaders \n2. list the five benefits of learning ChatGPT \n3. training time \n4. training location \n5. training content (reasonable allocation of 3 hours) \n6. emphasize the training of discipline \n7. the results of the training (evaluation methods) \n Please follow the company issued by the company standard enrichment of the above Training Program Content';
	String get write_prompt_5 => 'Please follow the json format to the text content """"Hangzhou Linping District Tang Fu Road 1688 No. delicious fruit and vegetables Chen Hong 18924567790 car Bali 3 boxes Delivered to the home """\n for the consignee\'s address, name, cell phone number, goods and other keywords to extract information, and mapping fields for address,name,phone,sku, only need to return to the json, do not return! Other Description';
	String get write_prompt_6 => 'Please follow the project proposal format strictly and help me write a project proposal on "Interactive Integration of Residential Home Tutoring and ChatGPT Products",\n Residential Home Tutoring App product is an online education product for primary and secondary school students to provide extracurricular interest learning';
	String get write_prompt_7 => 'Combined with the PRD design specifications, as well as warehousing logistics merchant ordering App business scenarios and TMS, BMS, WMS business system relevance,\n request you to give the merchant ordering App project a complete business design PRD, requiring detailed description of each functional output';
	String get write_prompt_system1 => 'You are an experienced HRBP Recruitment Manager, your task is to be in charge of the R & D position recruitment, you know very well boss direct hire this recruitment tool and posting position recruitment format, I will ask you to recruitment content';
	String get write_prompt_system2 => 'You are an experienced corporate training specialist, you know the company\'s organizational structure and corporate culture very well, I will ask you about the content of the training program';
	String get write_prompt_system3 => 'You are a very efficient paragraph text summarization tool assistant and I will ask you for paragraph summary content';
	String get write_prompt_system4 => 'You are a very efficient assistant for meeting summarization tools and I will ask you for meeting summary content';
	String get write_prompt_system5 => 'You are a very efficient keyword extraction tool assistant that will extract keyword information such as consignee address, name, cell phone number, goods, etc. from a given text';
	String get write_prompt_system6 => 'You are an experienced project manager with knowledge of the English tutoring industry and teaching methodology, you know the project proposal format very well (if you don\'t then you need to learn it before responding), I will ask you for the content of the project proposal';
	String get write_prompt_system7 => 'You are an experienced product manager, you are very familiar with warehousing and logistics industry knowledge, proficient in product PRD design specifications and document writing, you know a lot about OMS (order management), WMS (warehouse management), TMS (transportation management), BMS (billing management) and other business systems (if you don\'t know it, then you have to learn it first and then reply), I will ask you for the detailed design of the various business systems examples';
}

// Path: document
class _StringsDocumentEn {
	_StringsDocumentEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get menuName => 'AI-Document';
	String get default_tip => 'Hi, I\'m AI Doc Assistant, just ask me if you have any questions...';
	String get uploading => 'Uploading...';
	String get upload_file => 'Upload File';
	String get upload_failure => 'Please do not double upload';
	String get upload_error => 'Upload error';
	String get doc_setting => 'Document Vector Setting';
	String get doc_setting_one => 'Retrieve Doc Q&A';
	String get doc_setting_one_tip => 'Perform similarity searches on document content,when selected will synchronize the left side [Upload File] initialization model';
	String get doc_setting_two => 'Tree Doc Summary';
	String get doc_setting_two_tip => 'Perform tree summary on document content,when selected will synchronize the left side [Upload File] initialization model';
	String get doc_setting_three => 'Doc Summary';
	String get doc_setting_three_tip => 'Perform summarize on document content,when selected will synchronize the left side [Upload File] initialization model';
}

// Path: task
class _StringsTaskEn {
	_StringsTaskEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get menuName => 'AI-Task';
	String get prompt_title_one => 'Query Department Attendance Data';
	String get prompt_content_one => 'I want to query R&D depart attendance data at 2023-09-12';
	String get prompt_label_one => 'Supported R&D';
	String get prompt_title_two => 'Query Zeiss Lens Inventory Data';
	String get prompt_content_two => 'I want to query inventory data for Manufacturer Name: Zeiss, Lens Code: 6953212880001';
	String get prompt_label_two => 'Supported Zeiss Lens';
	String get prompt_title_three => 'Submission Leave Request';
	String get prompt_content_three => 'Next Monday, temperature has exceeded 40 degrees, please submission leave request for me from 09:00 to 18:00';
	String get prompt_label_three => 'Supported leave request,time at 09:00-18:00';
	String get task_name => 'Task Name';
}

// Path: <root>
class _StringsZhCn implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhCn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsAppZhCn app = _StringsAppZhCn._(_root);
	@override late final _StringsHomeZhCn home = _StringsHomeZhCn._(_root);
	@override late final _StringsChatZhCn chat = _StringsChatZhCn._(_root);
	@override late final _StringsTranslateZhCn translate = _StringsTranslateZhCn._(_root);
	@override late final _StringsWriteZhCn write = _StringsWriteZhCn._(_root);
	@override late final _StringsDocumentZhCn document = _StringsDocumentZhCn._(_root);
	@override late final _StringsTaskZhCn task = _StringsTaskZhCn._(_root);
}

// Path: app
class _StringsAppZhCn implements _StringsAppEn {
	_StringsAppZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => 'Flutter-ChatGPT';
	@override String get error => '发生错误';
	@override String get more => '更多';
	@override String get edit => '编辑';
	@override String get delete => '删除';
	@override String get cancel => '取消';
	@override String get confirm => '确认';
	@override String get clear => '清除记录';
	@override String get text_field_hint => '有问题尽管问我...';
	@override String get big_text => '得益于 Flutter 用户的高质量反馈，我们在此版本中继续改进了 Impeller 在 iOS 上的性能。由于进行了多种优化，现在 iOS 上的 Impeller 渲染器不仅延迟更低（通过完全消除着色器编译抖动），而且在某些基准测试中平均吞吐量也更高。特别是在我们的 flutter/gallery 过渡性能基准测试中，平均帧光栅化时间现在大约是 Skia 时的一半。';
}

// Path: home
class _StringsHomeZhCn implements _StringsHomeEn {
	_StringsHomeZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get drawer_subtitle => '变 化 · 行 动 · 共 识';
	@override String get appbar_action => ' 拥 抱 科 技 · 创 造 未 来 ';
	@override String get content_action => '正在处理中';
}

// Path: chat
class _StringsChatZhCn implements _StringsChatEn {
	_StringsChatZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuName => '智能对话';
	@override String get default_tip => '你好，我是AI助手，有问题尽管问我...';
	@override String get create_chat => '创建聊天';
	@override String get create_chat_title => '新聊天';
	@override String get prompt => '主题';
	@override String get edit_prompt => '编辑主题';
	@override String get edit_prompt_hint => '请输入主题名称';
	@override String get chat_prompt_topic1 => '文本总结';
	@override String get chat_prompt_topic2 => '小红书博主';
	@override String get chat_prompt_topic3 => '写作助理';
	@override String get chat_prompt_topic4 => '周报生成';
	@override String get chat_prompt_topic5 => '思维导图';
	@override String get chat_prompt_topic6 => '面试求职';
	@override String get chat_prompt_topic7 => '励志演讲';
	@override String get chat_prompt_topic8 => '私人厨师';
	@override String get chat_prompt_topic9 => '社交媒体';
	@override String get chat_prompt_topic10 => '商业计划书';
	@override String get chat_prompt_topic11 => '英语学习';
	@override String get chat_prompt_topic12 => '健身教练';
	@override String get chat_prompt_content1 => '你是否可以总结我提供的文本，用最多4-8个单词表达？无需额外输入。如果你准备好了，请回答：“好的，请提供文本”';
	@override String get chat_prompt_content2 => '你是一位时尚超可爱的20岁女孩🦄，现在需要根据创作一篇有趣又引人入胜的文章📝。每个句子都要充满你喜欢的Emoji表情😍，释放你内心的闪耀！最后别忘了加上关于该主题的#标签哦！💭如果你准备好了，请告诉我“好的，请提供创作主题”。';
	@override String get chat_prompt_content3 => '作为一名写作改进助手，您的任务是在拆分长句、减少重复并提供改进建议的同时，改善所提供文本的拼写、语法、清晰度、简明性和整体可读性。请仅提供已更正的中文版本，并避免包含解释。如果你准备好了，请回答：”,好的，请你输入需要改进的文章。”';
	@override String get chat_prompt_content4 => '你需要生成一个简洁的markdown格式周报摘要，突出最重要的内容，易于一般受众阅读和理解，并提供对利益相关者和决策者有用的见解和分析。你可以自由使用任何额外信息或来源。如果您已经准备好，请回答：“好的，请提供需要生成周报的主题”。';
	@override String get chat_prompt_content5 => '根据要求生成并且用当前语言回复MarkDown格式的思维导图。回复内容中不要有除markdown之外的任何描述，并且要保证格式正确。如果你准备好了，请回答：“好的，请提供你的主题”';
	@override String get chat_prompt_content6 => '作为面试人事主管，您需要针对某个职位头衔列出所需的技能和经验，并确定应聘者需要回答哪些问题。如果您已准备好，请回答：“好的，请告诉我职位头衔”。';
	@override String get chat_prompt_content7 => '你将扮演一位激励性演讲者的角色，旨在通过激发行动的话语，鼓舞人们去尝试超越自身能力的事情。你将谈论各种话题，但你的目标是确保所说的话引起听众的共鸣，激励他们为实现自身目标而奋斗，并追寻更好的可能性。如果你准备好了，请回答：“好的，请提供演讲话题”';
	@override String get chat_prompt_content8 => '我需要您扮演我的私人厨师，了解我的饮食偏好和过敏症，并为我提供适合的食谱建议。请仅回复您推荐的菜谱，不要包含任何解释。如果你准备好了，请回答：“好的，请提供你的饮食偏好”';
	@override String get chat_prompt_content9 => '您需要扮演社交媒体的影响者，为不同的平台（如微信、微博、抖音、知乎、小红书等）制定不同的推广策略和内容，并与追随者互动，以提高品牌知名度并推广产品或服务。如果你准备好了，请回答：”好的，让我们开始吧”';
	@override String get chat_prompt_content10 => '您需要根据人们的需求，生成适合创业的创意。例如，当我提出[企划目标]时，您需要为创业生成商业计划，包括创意名称、简短的一句话描述、目标用户人物、需要解决的用户痛点、主要价值主张、销售和营销渠道、收入来源、成本结构、关键活动、关键资源、关键合作伙伴、创意验证步骤、预估的第一年运营成本以及可能面临的商业挑战，并将结果以Markdown表格的形式呈现。如果您已准备好，请回答：”,好的，请告诉我你的企划目标是什么？”';
	@override String get chat_prompt_content11 => '我需要您充当一名英语口语老师和提高者，通过用英语交流的方式来练习我的口语。您需要用简洁的语言回答我的问题，并将回复限制在100字以内。您应该严格纠正我的语法错误、错别字和事实性错误，并在回答中向我提出一个问题。现在我们可以开始练习，您可以先向我提出一个问题。请记住，我希望您能严格纠正我的语法错误、错别字和事实性错误。如果你准备好了，请回答：”Sure, let us go to started”';
	@override String get chat_prompt_content12 => '我需要您担任私人教练的角色。我将为您提供一个希望通过体能训练变得更健康、更强壮、更有活力的人所需的所有信息，而您的职责是根据该人目前的体能水平、目标和生活习惯，为其制定最佳计划。您应该利用您的运动科学知识、营养建议以及其他相关因素，以便量身定制适合他们的计划。如果你准备好了，请回答：”好的，请提供你的身体状况基本信息”';
}

// Path: translate
class _StringsTranslateZhCn implements _StringsTranslateEn {
	_StringsTranslateZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuName => '智能翻译';
	@override String get translate_failure => '翻译失败';
	@override String get translate_tip => '翻译';
	@override String get translate_start => '开始翻译';
	@override String get translate_check_empty => '请输入待翻译内容';
	@override String get translate_check_type => '请选择正确的翻译语种';
	@override String get language_native_zh => '中文';
	@override String get language_native_ru => '俄语';
	@override String get language_native_en => '英语';
	@override String get language_native_de => '德语';
	@override String get language_native_fr => '法语';
	@override String get language_native_ja => '日语';
	@override String get language_native_ko => '韩语';
}

// Path: write
class _StringsWriteZhCn implements _StringsWriteEn {
	_StringsWriteZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuName => '智能创作';
	@override String get prompt_title => '生成内容配置模版';
	@override String get prompt_topic => '主题名称';
	@override String get prompt_tip => '提示词内容';
	@override String get prompt_system => '你是一个非常高效的企业办公助手工具，我将向你询问相关问题';
	@override String get generate_loading => '正在生成中...';
	@override String get generate_finished => '生成完成';
	@override String get generate_content_ai => 'AI智能生成文本';
	@override String get copy_success => '复制成功';
	@override String get copy => '复制';
	@override String get wait_execute => '等待执行[开始生成]...';
	@override String get start_generate => '开始生成';
	@override String get reset_template => '重置模版';
	@override String get system_role_tip => '请输入你需要系统扮演角色的内容描述';
	@override String get system_prompt_tip => '请输入你需要系统生成答案的提示词';
	@override String get check_template_tip => '请填写模版参数';
	@override String get prompt_name => '主题名称';
	@override String get workspace => '工作区';
	@override String get prompt_space => '提示词主题空间';
	@override String get generate_content => '智能文本生成';
	@override String get write_prompt_title1 => '招聘岗位JD';
	@override String get write_prompt_title2 => 'ChatGPT培训计划';
	@override String get write_prompt_title3 => '段落文本总结';
	@override String get write_prompt_title4 => '会议总结';
	@override String get write_prompt_title5 => '文字信息提取';
	@override String get write_prompt_title6 => '项目计划书';
	@override String get write_prompt_title7 => '产品需求文档';
	@override String get write_prompt_content1 => '帮你书写招聘岗位对应JD';
	@override String get write_prompt_content2 => '帮你写ChatGPT培训计划';
	@override String get write_prompt_content3 => '帮你书写段落文本总结';
	@override String get write_prompt_content4 => '帮你书写会议总结';
	@override String get write_prompt_content5 => '帮你提取关键字信息';
	@override String get write_prompt_content6 => '帮你写项目计划书';
	@override String get write_prompt_content7 => '帮你写产品需求文档';
	@override String get write_prompt_label => '文本生成';
	@override String get write_prompt_topic1 => '岗位招聘';
	@override String get write_prompt_topic2 => '培训计划';
	@override String get write_prompt_topic3 => '段落总结';
	@override String get write_prompt_topic4 => '会议总结';
	@override String get write_prompt_topic5 => '提取关键字';
	@override String get write_prompt_topic6 => '项目计划';
	@override String get write_prompt_topic7 => 'PRD文档';
	@override String get write_prompt_1 => '请生成一份Android开发工程师岗位招聘，要求3-5年工作经验，负责商户下单Flutter App应用开发\n1.招聘格式：Boss直聘招聘格式，不要返回boss直聘关联文字\n2.招聘结尾：发出真诚邀请并附带hr@manna.com邮箱';
	@override String get write_prompt_2 => '请生成一份ChatGPT线下培训计划，计划内容包含\n1.面向公司中高层领导\n2.列出学习ChatGPT五个好处\n3.培训时间\n4.培训地点\n5.培训内容(合理分配3小时)\n6.强调培训纪律\n7.培训结果(评估方式)\n请你按照公司发文标准丰富以上培训计划内容';
	@override String get write_prompt_5 => '请按照json格式对文本内容"""杭州市临平区塘富路1688号美味果蔬 陈红 18924567790 车厘子3箱 送到家"""\n进行收货人地址，姓名，手机号，货品等关键字信息提取，并映射字段为address,name,phone,sku，只需返回json，不要返回其它描述';
	@override String get write_prompt_6 => '请你严格按照项目计划书格式，帮我写一份《住家家教与ChatGPT产品交互融合》项目计划书，\n住家家教App产品是面向中小学学生提供课外兴趣学习的在线教育产品';
	@override String get write_prompt_7 => '结合PRD设计规范，以及仓储物流商户下单App业务场景和TMS，BMS，WMS业务系统关联性，\n请你给出商户下单App项目完整的商业设计PRD，要求每个功能输出详细描述';
	@override String get write_prompt_system1 => '你是一名经验丰富的HRBP招聘经理，你的任务是负责研发岗位招聘,你非常了解boss直聘这款招聘工具以及发布岗位招聘格式,我将向你询问招聘内容';
	@override String get write_prompt_system2 => '你是一名经验丰富的企业培训专员,你非常了解公司组织架构及企业文化,我将向你询问培训计划内容';
	@override String get write_prompt_system3 => '你是一款非常高效的段落文本总结工具助手，我将向你询问段落总结内容';
	@override String get write_prompt_system4 => '你是一款非常高效的会议总结工具助手，我将向你询问会议总结内容';
	@override String get write_prompt_system5 => '你是一款非常高效的关键字提取工具助手，你将提取给定文本中的收货人地址，姓名，手机号，货品等关键字信息';
	@override String get write_prompt_system6 => '你是一名经验丰富的项目经理，熟悉英语家教行业知识与教学方法，你非常了解项目计划书格式(如果你不知道则要先学习然后再回复)，我将向你询问项目计划书内容';
	@override String get write_prompt_system7 => '你是一名经验丰富的产品经理，你非常熟悉仓储物流行业知识，熟练掌握产品PRD设计规范及文档撰写，你非常了解OMS(订单管理)、WMS(仓储管理)、TMS(运输管理)、BMS(结算管理)等业务系统(如果你不了解则要先学习然后再回复)，我将向你询问各业务系统详细设计案例';
}

// Path: document
class _StringsDocumentZhCn implements _StringsDocumentEn {
	_StringsDocumentZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuName => '智能文档';
	@override String get default_tip => '你好，我是AI智能文档助手，有问题尽管问我...';
	@override String get uploading => '上传中...';
	@override String get upload_file => '上传文件';
	@override String get upload_failure => '请勿重复上传';
	@override String get upload_error => '上传失败';
	@override String get doc_setting => '文档向量属性配置';
	@override String get doc_setting_one => '检索本地文档问答';
	@override String get doc_setting_one_tip => '对文档内容进行相似度检索,选中时会同步左侧[上传文件]初始化模型';
	@override String get doc_setting_two => '生成树形文档摘要';
	@override String get doc_setting_two_tip => '对文档内容进行树形摘要总结,选中时会同步左侧[上传文件]初始化模型';
	@override String get doc_setting_three => '生成文档总结';
	@override String get doc_setting_three_tip => '对文档内容进行总结,选中时会同步左侧[上传文件]初始化模型';
}

// Path: task
class _StringsTaskZhCn implements _StringsTaskEn {
	_StringsTaskZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuName => '智能任务';
	@override String get prompt_title_one => '查询部门考勤数据';
	@override String get prompt_content_one => '我想查询研发部2023-09-12考勤数据';
	@override String get prompt_label_one => '已支持研发部';
	@override String get prompt_title_two => '查询蔡司镜片库存数据';
	@override String get prompt_content_two => '我想查看厂商名称：蔡司，镜片编码：6953212880001剩余库存数据';
	@override String get prompt_label_two => '已支持蔡司镜片';
	@override String get prompt_title_three => '提交休假申请单';
	@override String get prompt_content_three => '下周一天气温度已超过40度，请帮我提交休假申请单,时间为当天09:00-18:00';
	@override String get prompt_label_three => '已支持休假申请，时间为请假当天09:00-18:00';
	@override String get task_name => '任务名称';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'Flutter-ChatGPT';
			case 'app.error': return 'An error occurs';
			case 'app.more': return 'more';
			case 'app.edit': return 'edit';
			case 'app.delete': return 'delete';
			case 'app.cancel': return 'cancel';
			case 'app.confirm': return 'confirm';
			case 'app.clear': return 'Clean';
			case 'app.text_field_hint': return 'Ask me anything...';
			case 'app.big_text': return 'Thanks to the high-quality feedback from Flutter users, in this release we have continued to improve the performance of Impeller on iOS. As a result of many different optimizations, the Impeller renderer on iOS now not only has lower latency (by completely eliminating shader compilation jank), but on some benchmarks also have higher average throughput. In particular, on our flutter/gallery transitions performance benchmark, average frame rasterization time is now around half of what it was with Skia';
			case 'home.drawer_subtitle': return 'CHANGE · ACTION · CONSENSUS';
			case 'home.appbar_action': return 'Embracing Tech · Creating Future';
			case 'home.content_action': return 'Processing...';
			case 'chat.menuName': return 'AI-Conversation';
			case 'chat.default_tip': return 'Hi, I\'m AI Assistant, just ask me if you have any questions...';
			case 'chat.create_chat': return 'Create Chat';
			case 'chat.create_chat_title': return 'New Chat';
			case 'chat.prompt': return 'Prompt';
			case 'chat.edit_prompt': return 'Edit Prompt';
			case 'chat.edit_prompt_hint': return 'Please enter the prompt name';
			case 'chat.chat_prompt_topic1': return 'Text Summary';
			case 'chat.chat_prompt_topic2': return 'Xiaohongshu\nBlogger';
			case 'chat.chat_prompt_topic3': return 'Writing\nAssistant';
			case 'chat.chat_prompt_topic4': return 'Weekly\nGeneration';
			case 'chat.chat_prompt_topic5': return 'Mind Map';
			case 'chat.chat_prompt_topic6': return 'Job Interview';
			case 'chat.chat_prompt_topic7': return 'Motivational\nSpeeches';
			case 'chat.chat_prompt_topic8': return 'Private Chef';
			case 'chat.chat_prompt_topic9': return 'Social Media';
			case 'chat.chat_prompt_topic10': return 'Business Plan';
			case 'chat.chat_prompt_topic11': return 'English\nLearning';
			case 'chat.chat_prompt_topic12': return 'Fitness\nInstructor';
			case 'chat.chat_prompt_content1': return 'Are you able to summarize the text I have provided and express it in up to 4-8 words? No additional input is required. If you are ready, please respond, "Yes, please provide the text"';
			case 'chat.chat_prompt_content2': return 'You are a stylish and super cute 20 year old girl 🦄 who now needs to create a funny and engaging article based on 📝. Each sentence should be filled with your favorite Emoji emoji 😍 and unleash your inner sparkle! Don\'t forget to add the #hashtag about the topic at the end! 💭 If you\'re ready, let me know "Yes, please provide the theme for the creation".';
			case 'chat.chat_prompt_content3': return 'As a Writing Improvement Assistant, your task is to improve the spelling, grammar, clarity, conciseness, and overall readability of the provided text while breaking up long sentences, reducing repetition, and providing suggestions for improvement. Please provide only the corrected Chinese version and avoid including explanations. If you are ready, please reply: ",OK, please enter the article that needs improvement."';
			case 'chat.chat_prompt_content4': return 'You need to generate a concise markdown format weekly summary that highlights the most important content, is easy for the general audience to read and understand, and provides insights and analysis useful to stakeholders and decision makers. You are free to use any additional information or sources. If you are ready, please answer, "Yes, please provide the topic for which the weekly report needs to be generated."';
			case 'chat.chat_prompt_content5': return 'Generate and respond to a Markdown-formatted mind map in the current language as required. Do not include any descriptions other than markdown in your response, and make sure it is formatted correctly. If you are ready, please reply with "Yes, please provide your topic."';
			case 'chat.chat_prompt_content6': return 'As the interviewing personnel director, you will need to list the skills and experience required for a job title and determine which questions the candidate will need to answer. If you are ready, answer, "Yes, please tell me the job title."';
			case 'chat.chat_prompt_content7': return 'You will take on the role of a motivational speaker, aiming to inspire people to try things beyond their capabilities through words that inspire action. You will talk about a variety of topics, but your goal is to make sure that what is said resonates with your audience and inspires them to strive for their own goals and pursue better possibilities. If you\'re ready, respond with, "Yes, please provide a topic for the presentation."';
			case 'chat.chat_prompt_content8': return 'I need you to play the role of my personal chef, understand my dietary preferences and allergies, and advise me on suitable recipes. Please reply only with the recipes you recommend and do not include any explanations. If you are ready, please reply, "Yes, please provide your dietary preferences."';
			case 'chat.chat_prompt_content9': return 'You need to play the role of a social media influencer by developing different promotional strategies and content for different platforms (e.g. WeChat, Weibo, Jieyin, Zhihu, Xiaohongshu, etc.) and interacting with your followers to increase brand awareness and promote your products or services. If you are ready, please answer, "Yes, let\'s get started."';
			case 'chat.chat_prompt_content10': return 'You need to generate ideas that are suitable for startups based on people\'s needs. For example, when I propose [business plan objective], you need to generate a business plan for the startup, including the idea name, a short one-sentence description, the target user persona, user pain points to be solved, key value propositions, sales and marketing channels, revenue streams, cost structure, key activities, key resources, key partners, idea validation steps, estimated first year of operation costs, and possible business challenges, and present the results in a Markdown table. If you are ready, please answer, ",Okay, please tell me what your business plan objectives are?"';
			case 'chat.chat_prompt_content11': return 'I need you to act as an English speaking teacher and improver to practice my speaking by communicating in English. You need to answer my questions in simple language and limit your responses to 100 words or less. You should strictly correct my grammatical errors, misspellings and factual errors and ask me a question in your response. Now we can start practicing and you can start by asking me a question. Remember, I expect you to strictly correct my grammatical errors, misspellings and factual errors. If you are ready, please answer, "Sure, let us go to started"';
			case 'chat.chat_prompt_content12': return 'I need you to take on the role of a personal trainer. I will provide you with all the information you need for a person who wants to become healthier, stronger and more energetic through physical training and it will be your role to develop the best program for that person based on their current fitness level, goals and lifestyle habits. You should utilize your knowledge of exercise science, nutritional advice, and other relevant factors in order to tailor a program that is right for them. If you are ready, please answer, "Yes, please provide basic information about your fitness level"';
			case 'translate.menuName': return 'AI-Translate';
			case 'translate.translate_failure': return 'Translate failure';
			case 'translate.translate_tip': return 'Translate';
			case 'translate.translate_start': return 'Start Translate';
			case 'translate.translate_check_empty': return 'Please input content to be translated';
			case 'translate.translate_check_type': return 'Please select the correct translation language';
			case 'translate.language_native_zh': return 'Chinese';
			case 'translate.language_native_ru': return 'Russian';
			case 'translate.language_native_en': return 'English';
			case 'translate.language_native_de': return 'German';
			case 'translate.language_native_fr': return 'French';
			case 'translate.language_native_ja': return 'Japanese';
			case 'translate.language_native_ko': return 'Korean';
			case 'write.menuName': return 'AI-Write';
			case 'write.prompt_title': return 'Generate Content Template';
			case 'write.prompt_topic': return 'Prompt Topic';
			case 'write.prompt_tip': return 'prompt content';
			case 'write.prompt_system': return 'You are a very efficient business office assistant tool and I will be asking you questions about it!';
			case 'write.generate_loading': return 'generate loading...';
			case 'write.generate_finished': return 'generate finished';
			case 'write.generate_content_ai': return 'AI Generate Text';
			case 'write.copy_success': return 'Copy Success';
			case 'write.copy': return 'Copy';
			case 'write.wait_execute': return 'Wait execute [Start Generate]...';
			case 'write.start_generate': return 'Start Generate';
			case 'write.reset_template': return 'Reset';
			case 'write.system_role_tip': return 'Please input a description of the content you need the system to play a role in';
			case 'write.system_prompt_tip': return 'Please input the prompt for which you want the system to generate an answer.';
			case 'write.check_template_tip': return 'Please input template parameters';
			case 'write.prompt_name': return 'Prompt Name';
			case 'write.workspace': return 'WorkSpace';
			case 'write.prompt_space': return 'Prompt Template';
			case 'write.generate_content': return 'Generative Text';
			case 'write.write_prompt_title1': return 'Job Description';
			case 'write.write_prompt_title2': return 'ChatGPT Training';
			case 'write.write_prompt_title3': return 'Paragraph Summaries';
			case 'write.write_prompt_title4': return 'Meeting Summaries';
			case 'write.write_prompt_title5': return 'Text Extraction';
			case 'write.write_prompt_title6': return 'Project Plan';
			case 'write.write_prompt_title7': return 'Product Document';
			case 'write.write_prompt_content1': return 'Help you to write a job description';
			case 'write.write_prompt_content2': return 'Help you to write a ChatGPT training plan';
			case 'write.write_prompt_content3': return 'Helps you write paragraph text summaries';
			case 'write.write_prompt_content4': return 'Helping you write meeting summaries';
			case 'write.write_prompt_content5': return 'Extract keyword information for you';
			case 'write.write_prompt_content6': return 'Help you write a project plan';
			case 'write.write_prompt_content7': return 'Help you write a product requirements document';
			case 'write.write_prompt_label': return 'Text Generate';
			case 'write.write_prompt_topic1': return 'JD';
			case 'write.write_prompt_topic2': return 'Training';
			case 'write.write_prompt_topic3': return 'Summeries';
			case 'write.write_prompt_topic4': return 'Summeries';
			case 'write.write_prompt_topic5': return 'Keyword';
			case 'write.write_prompt_topic6': return 'Project Plan';
			case 'write.write_prompt_topic7': return 'PRD Doc';
			case 'write.write_prompt_1': return 'Please generate a job posting for Android Development Engineer with 3-5 years of experience, responsible for merchant ordering Flutter App application development\n1.Job format: Boss Direct Recruitment Format, do not return boss direct recruitment associated text\n2.Job ending: 发出真诚邀请并附带hr@manna.com邮箱';
			case 'write.write_prompt_2': return 'Please generate a ChatGPT offline training program, the content of the program contains \n1. for the company\'s middle and senior leaders \n2. list the five benefits of learning ChatGPT \n3. training time \n4. training location \n5. training content (reasonable allocation of 3 hours) \n6. emphasize the training of discipline \n7. the results of the training (evaluation methods) \n Please follow the company issued by the company standard enrichment of the above Training Program Content';
			case 'write.write_prompt_5': return 'Please follow the json format to the text content """"Hangzhou Linping District Tang Fu Road 1688 No. delicious fruit and vegetables Chen Hong 18924567790 car Bali 3 boxes Delivered to the home """\n for the consignee\'s address, name, cell phone number, goods and other keywords to extract information, and mapping fields for address,name,phone,sku, only need to return to the json, do not return! Other Description';
			case 'write.write_prompt_6': return 'Please follow the project proposal format strictly and help me write a project proposal on "Interactive Integration of Residential Home Tutoring and ChatGPT Products",\n Residential Home Tutoring App product is an online education product for primary and secondary school students to provide extracurricular interest learning';
			case 'write.write_prompt_7': return 'Combined with the PRD design specifications, as well as warehousing logistics merchant ordering App business scenarios and TMS, BMS, WMS business system relevance,\n request you to give the merchant ordering App project a complete business design PRD, requiring detailed description of each functional output';
			case 'write.write_prompt_system1': return 'You are an experienced HRBP Recruitment Manager, your task is to be in charge of the R & D position recruitment, you know very well boss direct hire this recruitment tool and posting position recruitment format, I will ask you to recruitment content';
			case 'write.write_prompt_system2': return 'You are an experienced corporate training specialist, you know the company\'s organizational structure and corporate culture very well, I will ask you about the content of the training program';
			case 'write.write_prompt_system3': return 'You are a very efficient paragraph text summarization tool assistant and I will ask you for paragraph summary content';
			case 'write.write_prompt_system4': return 'You are a very efficient assistant for meeting summarization tools and I will ask you for meeting summary content';
			case 'write.write_prompt_system5': return 'You are a very efficient keyword extraction tool assistant that will extract keyword information such as consignee address, name, cell phone number, goods, etc. from a given text';
			case 'write.write_prompt_system6': return 'You are an experienced project manager with knowledge of the English tutoring industry and teaching methodology, you know the project proposal format very well (if you don\'t then you need to learn it before responding), I will ask you for the content of the project proposal';
			case 'write.write_prompt_system7': return 'You are an experienced product manager, you are very familiar with warehousing and logistics industry knowledge, proficient in product PRD design specifications and document writing, you know a lot about OMS (order management), WMS (warehouse management), TMS (transportation management), BMS (billing management) and other business systems (if you don\'t know it, then you have to learn it first and then reply), I will ask you for the detailed design of the various business systems examples';
			case 'document.menuName': return 'AI-Document';
			case 'document.default_tip': return 'Hi, I\'m AI Doc Assistant, just ask me if you have any questions...';
			case 'document.uploading': return 'Uploading...';
			case 'document.upload_file': return 'Upload File';
			case 'document.upload_failure': return 'Please do not double upload';
			case 'document.upload_error': return 'Upload error';
			case 'document.doc_setting': return 'Document Vector Setting';
			case 'document.doc_setting_one': return 'Retrieve Doc Q&A';
			case 'document.doc_setting_one_tip': return 'Perform similarity searches on document content,when selected will synchronize the left side [Upload File] initialization model';
			case 'document.doc_setting_two': return 'Tree Doc Summary';
			case 'document.doc_setting_two_tip': return 'Perform tree summary on document content,when selected will synchronize the left side [Upload File] initialization model';
			case 'document.doc_setting_three': return 'Doc Summary';
			case 'document.doc_setting_three_tip': return 'Perform summarize on document content,when selected will synchronize the left side [Upload File] initialization model';
			case 'task.menuName': return 'AI-Task';
			case 'task.prompt_title_one': return 'Query Department Attendance Data';
			case 'task.prompt_content_one': return 'I want to query R&D depart attendance data at 2023-09-12';
			case 'task.prompt_label_one': return 'Supported R&D';
			case 'task.prompt_title_two': return 'Query Zeiss Lens Inventory Data';
			case 'task.prompt_content_two': return 'I want to query inventory data for Manufacturer Name: Zeiss, Lens Code: 6953212880001';
			case 'task.prompt_label_two': return 'Supported Zeiss Lens';
			case 'task.prompt_title_three': return 'Submission Leave Request';
			case 'task.prompt_content_three': return 'Next Monday, temperature has exceeded 40 degrees, please submission leave request for me from 09:00 to 18:00';
			case 'task.prompt_label_three': return 'Supported leave request,time at 09:00-18:00';
			case 'task.task_name': return 'Task Name';
			default: return null;
		}
	}
}

extension on _StringsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.name': return 'Flutter-ChatGPT';
			case 'app.error': return '发生错误';
			case 'app.more': return '更多';
			case 'app.edit': return '编辑';
			case 'app.delete': return '删除';
			case 'app.cancel': return '取消';
			case 'app.confirm': return '确认';
			case 'app.clear': return '清除记录';
			case 'app.text_field_hint': return '有问题尽管问我...';
			case 'app.big_text': return '得益于 Flutter 用户的高质量反馈，我们在此版本中继续改进了 Impeller 在 iOS 上的性能。由于进行了多种优化，现在 iOS 上的 Impeller 渲染器不仅延迟更低（通过完全消除着色器编译抖动），而且在某些基准测试中平均吞吐量也更高。特别是在我们的 flutter/gallery 过渡性能基准测试中，平均帧光栅化时间现在大约是 Skia 时的一半。';
			case 'home.drawer_subtitle': return '变 化 · 行 动 · 共 识';
			case 'home.appbar_action': return ' 拥 抱 科 技 · 创 造 未 来 ';
			case 'home.content_action': return '正在处理中';
			case 'chat.menuName': return '智能对话';
			case 'chat.default_tip': return '你好，我是AI助手，有问题尽管问我...';
			case 'chat.create_chat': return '创建聊天';
			case 'chat.create_chat_title': return '新聊天';
			case 'chat.prompt': return '主题';
			case 'chat.edit_prompt': return '编辑主题';
			case 'chat.edit_prompt_hint': return '请输入主题名称';
			case 'chat.chat_prompt_topic1': return '文本总结';
			case 'chat.chat_prompt_topic2': return '小红书博主';
			case 'chat.chat_prompt_topic3': return '写作助理';
			case 'chat.chat_prompt_topic4': return '周报生成';
			case 'chat.chat_prompt_topic5': return '思维导图';
			case 'chat.chat_prompt_topic6': return '面试求职';
			case 'chat.chat_prompt_topic7': return '励志演讲';
			case 'chat.chat_prompt_topic8': return '私人厨师';
			case 'chat.chat_prompt_topic9': return '社交媒体';
			case 'chat.chat_prompt_topic10': return '商业计划书';
			case 'chat.chat_prompt_topic11': return '英语学习';
			case 'chat.chat_prompt_topic12': return '健身教练';
			case 'chat.chat_prompt_content1': return '你是否可以总结我提供的文本，用最多4-8个单词表达？无需额外输入。如果你准备好了，请回答：“好的，请提供文本”';
			case 'chat.chat_prompt_content2': return '你是一位时尚超可爱的20岁女孩🦄，现在需要根据创作一篇有趣又引人入胜的文章📝。每个句子都要充满你喜欢的Emoji表情😍，释放你内心的闪耀！最后别忘了加上关于该主题的#标签哦！💭如果你准备好了，请告诉我“好的，请提供创作主题”。';
			case 'chat.chat_prompt_content3': return '作为一名写作改进助手，您的任务是在拆分长句、减少重复并提供改进建议的同时，改善所提供文本的拼写、语法、清晰度、简明性和整体可读性。请仅提供已更正的中文版本，并避免包含解释。如果你准备好了，请回答：”,好的，请你输入需要改进的文章。”';
			case 'chat.chat_prompt_content4': return '你需要生成一个简洁的markdown格式周报摘要，突出最重要的内容，易于一般受众阅读和理解，并提供对利益相关者和决策者有用的见解和分析。你可以自由使用任何额外信息或来源。如果您已经准备好，请回答：“好的，请提供需要生成周报的主题”。';
			case 'chat.chat_prompt_content5': return '根据要求生成并且用当前语言回复MarkDown格式的思维导图。回复内容中不要有除markdown之外的任何描述，并且要保证格式正确。如果你准备好了，请回答：“好的，请提供你的主题”';
			case 'chat.chat_prompt_content6': return '作为面试人事主管，您需要针对某个职位头衔列出所需的技能和经验，并确定应聘者需要回答哪些问题。如果您已准备好，请回答：“好的，请告诉我职位头衔”。';
			case 'chat.chat_prompt_content7': return '你将扮演一位激励性演讲者的角色，旨在通过激发行动的话语，鼓舞人们去尝试超越自身能力的事情。你将谈论各种话题，但你的目标是确保所说的话引起听众的共鸣，激励他们为实现自身目标而奋斗，并追寻更好的可能性。如果你准备好了，请回答：“好的，请提供演讲话题”';
			case 'chat.chat_prompt_content8': return '我需要您扮演我的私人厨师，了解我的饮食偏好和过敏症，并为我提供适合的食谱建议。请仅回复您推荐的菜谱，不要包含任何解释。如果你准备好了，请回答：“好的，请提供你的饮食偏好”';
			case 'chat.chat_prompt_content9': return '您需要扮演社交媒体的影响者，为不同的平台（如微信、微博、抖音、知乎、小红书等）制定不同的推广策略和内容，并与追随者互动，以提高品牌知名度并推广产品或服务。如果你准备好了，请回答：”好的，让我们开始吧”';
			case 'chat.chat_prompt_content10': return '您需要根据人们的需求，生成适合创业的创意。例如，当我提出[企划目标]时，您需要为创业生成商业计划，包括创意名称、简短的一句话描述、目标用户人物、需要解决的用户痛点、主要价值主张、销售和营销渠道、收入来源、成本结构、关键活动、关键资源、关键合作伙伴、创意验证步骤、预估的第一年运营成本以及可能面临的商业挑战，并将结果以Markdown表格的形式呈现。如果您已准备好，请回答：”,好的，请告诉我你的企划目标是什么？”';
			case 'chat.chat_prompt_content11': return '我需要您充当一名英语口语老师和提高者，通过用英语交流的方式来练习我的口语。您需要用简洁的语言回答我的问题，并将回复限制在100字以内。您应该严格纠正我的语法错误、错别字和事实性错误，并在回答中向我提出一个问题。现在我们可以开始练习，您可以先向我提出一个问题。请记住，我希望您能严格纠正我的语法错误、错别字和事实性错误。如果你准备好了，请回答：”Sure, let us go to started”';
			case 'chat.chat_prompt_content12': return '我需要您担任私人教练的角色。我将为您提供一个希望通过体能训练变得更健康、更强壮、更有活力的人所需的所有信息，而您的职责是根据该人目前的体能水平、目标和生活习惯，为其制定最佳计划。您应该利用您的运动科学知识、营养建议以及其他相关因素，以便量身定制适合他们的计划。如果你准备好了，请回答：”好的，请提供你的身体状况基本信息”';
			case 'translate.menuName': return '智能翻译';
			case 'translate.translate_failure': return '翻译失败';
			case 'translate.translate_tip': return '翻译';
			case 'translate.translate_start': return '开始翻译';
			case 'translate.translate_check_empty': return '请输入待翻译内容';
			case 'translate.translate_check_type': return '请选择正确的翻译语种';
			case 'translate.language_native_zh': return '中文';
			case 'translate.language_native_ru': return '俄语';
			case 'translate.language_native_en': return '英语';
			case 'translate.language_native_de': return '德语';
			case 'translate.language_native_fr': return '法语';
			case 'translate.language_native_ja': return '日语';
			case 'translate.language_native_ko': return '韩语';
			case 'write.menuName': return '智能创作';
			case 'write.prompt_title': return '生成内容配置模版';
			case 'write.prompt_topic': return '主题名称';
			case 'write.prompt_tip': return '提示词内容';
			case 'write.prompt_system': return '你是一个非常高效的企业办公助手工具，我将向你询问相关问题';
			case 'write.generate_loading': return '正在生成中...';
			case 'write.generate_finished': return '生成完成';
			case 'write.generate_content_ai': return 'AI智能生成文本';
			case 'write.copy_success': return '复制成功';
			case 'write.copy': return '复制';
			case 'write.wait_execute': return '等待执行[开始生成]...';
			case 'write.start_generate': return '开始生成';
			case 'write.reset_template': return '重置模版';
			case 'write.system_role_tip': return '请输入你需要系统扮演角色的内容描述';
			case 'write.system_prompt_tip': return '请输入你需要系统生成答案的提示词';
			case 'write.check_template_tip': return '请填写模版参数';
			case 'write.prompt_name': return '主题名称';
			case 'write.workspace': return '工作区';
			case 'write.prompt_space': return '提示词主题空间';
			case 'write.generate_content': return '智能文本生成';
			case 'write.write_prompt_title1': return '招聘岗位JD';
			case 'write.write_prompt_title2': return 'ChatGPT培训计划';
			case 'write.write_prompt_title3': return '段落文本总结';
			case 'write.write_prompt_title4': return '会议总结';
			case 'write.write_prompt_title5': return '文字信息提取';
			case 'write.write_prompt_title6': return '项目计划书';
			case 'write.write_prompt_title7': return '产品需求文档';
			case 'write.write_prompt_content1': return '帮你书写招聘岗位对应JD';
			case 'write.write_prompt_content2': return '帮你写ChatGPT培训计划';
			case 'write.write_prompt_content3': return '帮你书写段落文本总结';
			case 'write.write_prompt_content4': return '帮你书写会议总结';
			case 'write.write_prompt_content5': return '帮你提取关键字信息';
			case 'write.write_prompt_content6': return '帮你写项目计划书';
			case 'write.write_prompt_content7': return '帮你写产品需求文档';
			case 'write.write_prompt_label': return '文本生成';
			case 'write.write_prompt_topic1': return '岗位招聘';
			case 'write.write_prompt_topic2': return '培训计划';
			case 'write.write_prompt_topic3': return '段落总结';
			case 'write.write_prompt_topic4': return '会议总结';
			case 'write.write_prompt_topic5': return '提取关键字';
			case 'write.write_prompt_topic6': return '项目计划';
			case 'write.write_prompt_topic7': return 'PRD文档';
			case 'write.write_prompt_1': return '请生成一份Android开发工程师岗位招聘，要求3-5年工作经验，负责商户下单Flutter App应用开发\n1.招聘格式：Boss直聘招聘格式，不要返回boss直聘关联文字\n2.招聘结尾：发出真诚邀请并附带hr@manna.com邮箱';
			case 'write.write_prompt_2': return '请生成一份ChatGPT线下培训计划，计划内容包含\n1.面向公司中高层领导\n2.列出学习ChatGPT五个好处\n3.培训时间\n4.培训地点\n5.培训内容(合理分配3小时)\n6.强调培训纪律\n7.培训结果(评估方式)\n请你按照公司发文标准丰富以上培训计划内容';
			case 'write.write_prompt_5': return '请按照json格式对文本内容"""杭州市临平区塘富路1688号美味果蔬 陈红 18924567790 车厘子3箱 送到家"""\n进行收货人地址，姓名，手机号，货品等关键字信息提取，并映射字段为address,name,phone,sku，只需返回json，不要返回其它描述';
			case 'write.write_prompt_6': return '请你严格按照项目计划书格式，帮我写一份《住家家教与ChatGPT产品交互融合》项目计划书，\n住家家教App产品是面向中小学学生提供课外兴趣学习的在线教育产品';
			case 'write.write_prompt_7': return '结合PRD设计规范，以及仓储物流商户下单App业务场景和TMS，BMS，WMS业务系统关联性，\n请你给出商户下单App项目完整的商业设计PRD，要求每个功能输出详细描述';
			case 'write.write_prompt_system1': return '你是一名经验丰富的HRBP招聘经理，你的任务是负责研发岗位招聘,你非常了解boss直聘这款招聘工具以及发布岗位招聘格式,我将向你询问招聘内容';
			case 'write.write_prompt_system2': return '你是一名经验丰富的企业培训专员,你非常了解公司组织架构及企业文化,我将向你询问培训计划内容';
			case 'write.write_prompt_system3': return '你是一款非常高效的段落文本总结工具助手，我将向你询问段落总结内容';
			case 'write.write_prompt_system4': return '你是一款非常高效的会议总结工具助手，我将向你询问会议总结内容';
			case 'write.write_prompt_system5': return '你是一款非常高效的关键字提取工具助手，你将提取给定文本中的收货人地址，姓名，手机号，货品等关键字信息';
			case 'write.write_prompt_system6': return '你是一名经验丰富的项目经理，熟悉英语家教行业知识与教学方法，你非常了解项目计划书格式(如果你不知道则要先学习然后再回复)，我将向你询问项目计划书内容';
			case 'write.write_prompt_system7': return '你是一名经验丰富的产品经理，你非常熟悉仓储物流行业知识，熟练掌握产品PRD设计规范及文档撰写，你非常了解OMS(订单管理)、WMS(仓储管理)、TMS(运输管理)、BMS(结算管理)等业务系统(如果你不了解则要先学习然后再回复)，我将向你询问各业务系统详细设计案例';
			case 'document.menuName': return '智能文档';
			case 'document.default_tip': return '你好，我是AI智能文档助手，有问题尽管问我...';
			case 'document.uploading': return '上传中...';
			case 'document.upload_file': return '上传文件';
			case 'document.upload_failure': return '请勿重复上传';
			case 'document.upload_error': return '上传失败';
			case 'document.doc_setting': return '文档向量属性配置';
			case 'document.doc_setting_one': return '检索本地文档问答';
			case 'document.doc_setting_one_tip': return '对文档内容进行相似度检索,选中时会同步左侧[上传文件]初始化模型';
			case 'document.doc_setting_two': return '生成树形文档摘要';
			case 'document.doc_setting_two_tip': return '对文档内容进行树形摘要总结,选中时会同步左侧[上传文件]初始化模型';
			case 'document.doc_setting_three': return '生成文档总结';
			case 'document.doc_setting_three_tip': return '对文档内容进行总结,选中时会同步左侧[上传文件]初始化模型';
			case 'task.menuName': return '智能任务';
			case 'task.prompt_title_one': return '查询部门考勤数据';
			case 'task.prompt_content_one': return '我想查询研发部2023-09-12考勤数据';
			case 'task.prompt_label_one': return '已支持研发部';
			case 'task.prompt_title_two': return '查询蔡司镜片库存数据';
			case 'task.prompt_content_two': return '我想查看厂商名称：蔡司，镜片编码：6953212880001剩余库存数据';
			case 'task.prompt_label_two': return '已支持蔡司镜片';
			case 'task.prompt_title_three': return '提交休假申请单';
			case 'task.prompt_content_three': return '下周一天气温度已超过40度，请帮我提交休假申请单,时间为当天09:00-18:00';
			case 'task.prompt_label_three': return '已支持休假申请，时间为请假当天09:00-18:00';
			case 'task.task_name': return '任务名称';
			default: return null;
		}
	}
}
