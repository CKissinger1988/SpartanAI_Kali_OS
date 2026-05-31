import React from 'react';

export default function CloudInfrastructure() {
  return (
    <div className="flex flex-col gap-6">
      <div className="grid grid-cols-2 gap-4">
        <div className="bg-[#181818] p-4 rounded-lg">
          <div className="text-[11px] text-[#8e8e8e]">Nodes</div>
          <div className="text-2xl">0</div>
        </div>
        <div className="bg-[#181818] p-4 rounded-lg">
          <div className="text-[11px] text-[#8e8e8e]">Shards</div>
          <div className="text-2xl">0</div>
        </div>
      </div>
      <div className="bg-[#181818] rounded-lg overflow-hidden flex-1">
        <table className="w-full text-left text-[12px]">
          <thead>
            <tr className="border-b border-[#2b2b2b] text-[#8e8e8e]">
              <th className="p-3">VMID</th><th>Name</th><th>IP</th><th>Threat</th><th>Status</th>
            </tr>
          </thead>
          <tbody>
            {/* Table content mapping would go here */}
          </tbody>
        </table>
      </div>
    </div>
  );
}
