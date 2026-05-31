import React from 'react';

export default function MsfSessions() {
  return (
    <div className="flex flex-col gap-6">
      <div className="flex justify-between items-center">
        <h2 className="text-lg text-white">MSF / Meterpreter Sessions</h2>
        <button className="bg-[#1c1c2e] border border-[#333] text-[#4c82ff] px-3 py-1 rounded text-xs font-semibold cursor-pointer">
            Refresh Sessions
        </button>
      </div>
      <div className="bg-[#181818] rounded-lg overflow-hidden flex-1">
        <table className="w-full text-left text-[12px]">
          <thead>
            <tr className="border-b border-[#2b2b2b] text-[#8e8e8e]">
              <th className="p-3">ID</th><th>Type</th><th>Info</th><th>Tunnel</th><th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr>
                <td className="p-3" colSpan={5} className="text-center text-[#8e8e8e]">No active sessions found.</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}
