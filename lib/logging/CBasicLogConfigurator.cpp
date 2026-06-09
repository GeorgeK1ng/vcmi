/*
 * CBasicLogConfigurator.cpp, part of VCMI engine
 *
 * Authors: listed in file AUTHORS in main folder
 *
 * License: GNU General Public License v2.0 or later
 * Full text of license available in license.txt file, in main folder
 *
 */
#include "StdInc.h"
#include "CBasicLogConfigurator.h"
#include "CLogger.h"

#include "../CConfigHandler.h"
#include "../CConsoleHandler.h"

VCMI_LIB_NAMESPACE_BEGIN

CBasicLogConfigurator::CBasicLogConfigurator(boost::filesystem::path filePath, CConsoleHandler * const console, boost::filesystem::path rmgFilePath) :
	filePath(std::move(filePath)), rmgFilePath(std::move(rmgFilePath)), console(console), appendToLogFile(false) {}

void CBasicLogConfigurator::configureDefault()
{
	CLogger::getGlobalLogger()->addTarget(std::make_unique<CLogConsoleTarget>(console));
	addFileTargets();
}

void CBasicLogConfigurator::configure()
{
	try
	{
		const JsonNode & loggingNode = settings["logging"];
		if(loggingNode.isNull())
			throw std::runtime_error("Settings haven't been loaded.");

		// Configure loggers
		const JsonNode & loggers = loggingNode["loggers"];
		if(!loggers.isNull())
		{
			for(const auto & loggerNode : loggers.Vector())
			{
				// Get logger
				std::string name = loggerNode["domain"].String();
				CLogger * logger = CLogger::getLogger(CLoggerDomain(name));

				// Set log level
				std::string level = loggerNode["level"].String();
				logger->setLevel(getLogLevel(level));
				logGlobal->debug("Set log level %s => %d", name, level);
			}
		}
		CLogger::getGlobalLogger()->clearTargets();

		// Add console target
		auto consoleTarget = std::make_unique<CLogConsoleTarget>(console);
		const JsonNode & consoleNode = loggingNode["console"];
		if(!consoleNode.isNull())
		{
			const JsonNode & consoleFormatNode = consoleNode["format"];
			if(!consoleFormatNode.isNull()) consoleTarget->setFormatter(CLogFormatter(consoleFormatNode.String()));
			const JsonNode & consoleThresholdNode = consoleNode["threshold"];
			if(!consoleThresholdNode.isNull()) consoleTarget->setThreshold(getLogLevel(consoleThresholdNode.String()));
			const JsonNode & coloredConsoleEnabledNode = consoleNode["coloredOutputEnabled"];
			consoleTarget->setColoredOutputEnabled(coloredConsoleEnabledNode.Bool());

			CColorMapping colorMapping;
			const JsonNode & colorMappingNode = consoleNode["colorMapping"];
			if(!colorMappingNode.isNull())
			{
				for(const JsonNode & mappingNode : colorMappingNode.Vector())
				{
					std::string domain = mappingNode["domain"].String();
					std::string level = mappingNode["level"].String();
					std::string color = mappingNode["color"].String();
					colorMapping.setColorFor(CLoggerDomain(domain), getLogLevel(level), getConsoleColor(color));
				}
			}
			consoleTarget->setColorMapping(colorMapping);
		}
		CLogger::getGlobalLogger()->addTarget(std::move(consoleTarget));

		// Add file targets
		const JsonNode & fileNode = loggingNode["file"];
		if(!fileNode.isNull() && !fileNode["format"].isNull())
		{
			CLogFormatter formatter(fileNode["format"].String());
			addFileTargets(&formatter);
		}
		else
			addFileTargets();
	}
	catch(const std::exception & e)
	{
		logGlobal->error("Could not initialize the logging system due to configuration error/s."
								     "The logging system can be in a corrupted state. %s", e.what());
	}

	logGlobal->info("Initialized logging system based on settings successfully.");
	for (auto& domain : CLogManager::get().getRegisteredDomains())
	{
		logGlobal->info("[log level] %s => %s", domain,
                    ELogLevel::to_string(CLogger::getLogger(CLoggerDomain(domain))->getLevel()));
	}
}

void CBasicLogConfigurator::addFileTargets(const CLogFormatter * formatter)
{
	auto fileTarget = std::make_unique<CLogFileTarget>(filePath, appendToLogFile);
	if(formatter)
		fileTarget->setFormatter(*formatter);

	if(!rmgFilePath.empty())
	{
		const CLoggerDomain rmgDomain("rmg");
		fileTarget->excludeDomain(rmgDomain);

		auto rmgFileTarget = std::make_unique<CLogFileTarget>(rmgFilePath, appendToLogFile);
		if(formatter)
			rmgFileTarget->setFormatter(*formatter);
		CLogger::getLogger(rmgDomain)->clearTargets();
		CLogger::getLogger(rmgDomain)->addTarget(std::move(rmgFileTarget));
	}

	CLogger::getGlobalLogger()->addTarget(std::move(fileTarget));
	appendToLogFile = true;
}

ELogLevel::ELogLevel CBasicLogConfigurator::getLogLevel(const std::string & level)
{
	static const std::map<std::string, ELogLevel::ELogLevel> levelMap =
	{
		{"trace", ELogLevel::TRACE},
		{"debug", ELogLevel::DEBUG},
		{"info", ELogLevel::INFO},
		{"warn", ELogLevel::WARN},
		{"error", ELogLevel::ERROR},
	};

	const auto & levelPair = levelMap.find(level);
	if(levelPair != levelMap.end())
		return levelPair->second;
	else
		throw std::runtime_error("Log level " + level + " unknown.");
}

EConsoleTextColor CBasicLogConfigurator::getConsoleColor(const std::string & colorName)
{
	static const std::map<std::string, EConsoleTextColor> colorMap =
	{
		{"default", EConsoleTextColor::DEFAULT},
		{"green", EConsoleTextColor::GREEN},
		{"red", EConsoleTextColor::RED},
		{"magenta", EConsoleTextColor::MAGENTA},
		{"yellow", EConsoleTextColor::YELLOW},
		{"white", EConsoleTextColor::WHITE},
		{"gray", EConsoleTextColor::GRAY},
		{"teal", EConsoleTextColor::TEAL},
	};

	const auto & colorPair = colorMap.find(colorName);
	if(colorPair != colorMap.end())
		return colorPair->second;
	else
		throw std::runtime_error("Color " + colorName + " unknown.");
}

void CBasicLogConfigurator::deconfigure()
{
	auto l = CLogger::getGlobalLogger();
	if(l != nullptr)
		l->clearTargets();
	if(!rmgFilePath.empty())
		CLogger::getLogger(CLoggerDomain("rmg"))->clearTargets();
	appendToLogFile = true;
}

VCMI_LIB_NAMESPACE_END
