/*
 * Registry.h, part of VCMI engine
 *
 * License: GNU General Public License v2.0 or later
 */
#pragma once

namespace WindowsRegistry
{
	std::optional<std::wstring> readCurrentUserRegistryString(const std::wstring & subKey, const std::wstring & valueName);
	bool writeCurrentUserRegistryString(const std::wstring & subKey, const std::wstring & valueName, const std::wstring & value);
	void removeCurrentUserRegistryValue(const std::wstring & subKey, const std::wstring & valueName);
}
