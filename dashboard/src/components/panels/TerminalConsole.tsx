import React from 'react';

// This is a placeholder; will be expanded with actual content from legacy HTML
export default function TerminalConsole() {
  return (
    <div className="flex flex-col gap-4 h-full">
      <div className="flex-1 bg-[#1a1a1a] p-4 rounded-lg font-mono text-sm text-[#ccc] overflow-y-auto">
        {'>'} System initialized. Awaiting directives...
      </div>
      <div className="flex gap-2">
        <textarea className="flex-1 bg-[#1e1e1e] border border-[#333] p-2 rounded-md text-white font-mono text-sm" placeholder="Directive..." />
        <button className="bg-[#2a2a2a] text-white p-2 rounded-full cursor-pointer hover:bg-[#4c82ff]">🚀</button>
      </div>
    </div>
  );
}
